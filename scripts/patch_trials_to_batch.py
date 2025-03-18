import requests

PAYLOAD_API = "https://lssvip-research-payload.chiu41.com/api"
# batch_id = "678b17976b4a83255ebd8755"
# batch_id = "678d0c572ed96a72d57d43b9"
# batch_id = "678d9b132ed96a72d5a7c672"
# batch_id = "67acb07c4f53fc9c6af207cf"
# batch_id = "678b17976b4a83255ebd8755"
# batch_id = "67bfca684f53fc9c6ac0c1f1"
# batch_id = "67d0ef2c4f53fc9c6a7b8056"
# batch_id = "67c804004f53fc9c6abcd84f"
# batch_id = "67c85d5e4f53fc9c6ad87f66"
# batch_id = "67d111ec4f53fc9c6a7ef9d8"
# batch_id = "67d153794f53fc9c6a86068c"
batch_id = "67d4e8354f53fc9c6ae1aa2e"

# batch_id = "67c1d0c84f53fc9c6afdd7c6"

headers = {
    "Authorization": "users API-Key {}".format("11ef564d-226b-44e2-b9ac-6995ef8b037b"),
}


def unique_list(sequence):
    seen = set()
    return [x for x in sequence if not (x in seen or seen.add(x))]


try:
    response = requests.get(
        url=PAYLOAD_API
        + "/trials?depth=0&limit={}&where[batch][equals]={}".format(
            5000,
            batch_id,
        ),
        verify=False,
        headers=headers,
    )
    response.raise_for_status()
    print("successfully get latest trials of batch")
    latest_batch_trials = response.json()["docs"]
    prev_trials = unique_list([trial["id"] for trial in latest_batch_trials])

    response = requests.patch(
        url=PAYLOAD_API + "/batches/{}?depth=0".format(batch_id),
        json={"trials": prev_trials},
        verify=False,
        headers=headers,
    )
    response.raise_for_status()
    print("successfully patch trials to batches")
except Exception as e:
    print(
        "Patch trials to batches, Error:",
        str(e),
    )
