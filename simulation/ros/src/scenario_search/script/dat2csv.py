import pandas as pd
from pathlib import Path
from pprint import pprint
import requests
import subprocess

batch_id = "6685ecfbc25c36e55b5570c9"
payload_api = "https://lssvip-research-payload.chiu41.com/api"
USER_API_KEY = "11ef564d-226b-44e2-b9ac-6995ef8b037b"
headers = {
    "Authorization": "users API-Key {}".format(USER_API_KEY),
}

response = requests.get(
    payload_api + "/batches/{}?depth=0".format(batch_id),
    verify=False,
)
batch = response.json()

for trialId in batch["trials"]:
    response = requests.get(
        payload_api + "/trials/{}?depth=0".format(trialId), verify=False
    )
    trial = response.json()

    # if "esminiCsv" in trial and trial["esminiCsv"]:
    #     print(trial["id"])
    #     continue

    esiminDatId = trial["esminiDat"]
    response = requests.get(payload_api + "/esminiDats/{}".format(esiminDatId))
    esminiDat = response.json()

    url = esminiDat["url"]
    print(url)
    response = requests.get(
        url,
        verify=False,
    )
    response.raise_for_status()
    datContent = response.content
    datfilepath: Path = (
        Path("/project/mmsl_simulation/.cache/dat2csv") / url.split("/")[-1]
    )
    if not datfilepath.parent.exists():
        datfilepath.parent.mkdir(parents=True)
    with open(str(datfilepath), "wb") as f:
        f.write(datContent)

    result = subprocess.run(
        ["/project/mmsl_simulation/src/esmini/bin/dat2csv", str(datfilepath)],
        cwd=str(datfilepath.parent),
        capture_output=True,
        text=True,
    )

    newfilepath = datfilepath.with_suffix(".csv")
    df = pd.read_csv(newfilepath, skiprows=1)
    df.rename(columns=str.strip, inplace=True)
    df["name"] = df["name"].str.strip()
    df.to_csv(newfilepath, index=False)

    files = {
        "file": (
            newfilepath.name,
            open(
                str(newfilepath),
                "rb",
            ),
            "text/csv",
        )
    }
    # Make the POST request
    response = requests.post(
        payload_api + "/esminiCsvs",
        headers=headers,
        files=files,
        verify=False,
    )
    esminiCsv = response.json()
    pprint(esminiCsv)

    response = requests.patch(
        payload_api + "/trials/{}?depth=0".format(trialId),
        headers=headers,
        data={"esminiCsv": esminiCsv["doc"]["id"]},
        verify=False,
    )
    pprint(response.json())
    print()
