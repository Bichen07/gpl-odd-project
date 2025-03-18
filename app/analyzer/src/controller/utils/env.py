import os
from pathlib import Path
from dotenv import load_dotenv

current_folder_path = Path(os.path.abspath(__file__)).parent
dotenv_path = str(current_folder_path / "../../../.env")
load_dotenv(dotenv_path)
print(dotenv_path)

PAYLOAD_API = str(os.getenv("PAYLOAD_API"))
PAYLOAD_GRAPHQL_API = PAYLOAD_API + "/graphql"
print(PAYLOAD_API)
print(PAYLOAD_GRAPHQL_API)
