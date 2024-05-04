from src.shared import (Depends,
                        CommandHandler,
                        Result,
                        Error,
                        Created,
                        FirebaseProvider,
                        List)
from .command import CreateProjectCommand
from ...domain import InsertProjectEntity, InsertDeliverablesEntity
from ...infrastructure import ProjectsRepository
import uuid


class CreateProjectCommandHandler(CommandHandler[CreateProjectCommand, Created]):
    def __init__(self, project_repository: ProjectsRepository = Depends(),
                 firebase_provider: FirebaseProvider = Depends()):
        self._project_repository = project_repository
        self._firebase_provider = firebase_provider

    async def handle(self, command: CreateProjectCommand) -> Result[Created]:
        project_id = uuid.uuid4()

        projects_file_path = f"{command.branch}/projects/{project_id}/"

        submitted_deliverables: List[InsertDeliverablesEntity] = []

        for deliverable in command.deliverables:
            file = next((file for file in command.files if file.filename.__contains__(deliverable.identifier)), None)

            if not file:
                return Result.failure(Error.validation(f"File {deliverable.file_name} not found"))

            file_extension = file.filename.split('.')[-1]

            valid_deliverable_type = await self._project_repository.deliverable_type_is_valid(deliverable.type)
            if not valid_deliverable_type:
                return Result.failure(Error.validation(f"Deliverable type {deliverable.type} not found"))

            deliverable_id = uuid.uuid4()
            deliverable_file_name = projects_file_path + f"{deliverable_id}.{file_extension}"
            deliverable_url = await self._firebase_provider.upload_file(deliverable_file_name, file)

            submitted_deliverables.append(InsertDeliverablesEntity(
                type=deliverable.type,
                name=deliverable.name,
                url=deliverable_url,
                description=deliverable.description
            ))

        if submitted_deliverables.count() == 0:
            return Result.failure(Error.validation("No deliverables were submitted"))

        authors_str = ','.join(command.authors)
        deliverables_str = (';'
                            .join([f"{deliverable.type},{deliverable.name},{deliverable.url},{deliverable.description}"
                                   for deliverable in submitted_deliverables]))

        entity = InsertProjectEntity(
            assessor_id=command.assessor,
            project_id=project_id,
            project_type_id=command.type,
            project_title=command.title,
            project_description=command.description,
            project_status=command.status,
            authors_str=authors_str,
            deliverables_str=deliverables_str
        )

        result = await self._project_repository.insert_project(entity)
        if not result:
            return Result.failure(Error.unexpected('Could not create project'))

        return Result.success(Created())
