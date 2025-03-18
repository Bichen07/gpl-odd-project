import requests

PAYLOAD_API = "http://140.113.208.174:3020/api"
batch_id = "67d93a2fd8da7e14046d3736"

headers = {
    "Authorization": "users API-Key {}".format("982febe9-b8d3-4e4d-8083-f611a9f2bf93"),
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
