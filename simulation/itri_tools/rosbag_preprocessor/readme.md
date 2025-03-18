# Bag Preprocessor

## NOTE
* This package can be run without container.

## Prerequisition

```bash

$ pip3.8 install -r requirements.txt

```

or create a virtual environment

```bash

$ python3 -m venv bag_preprocessor

$ source bag_preprocessor/bin/activate

$ pip install -r requirements.txt


```

## Usage

### Extract only used topics from bags

1. Put all downloaded bags and folders inside downloaded_bags/ then run

```bash

$ python bag_extractor.py [-f FROM_FOLDER] [-t TO_FOLDER] [-r RECORD_JSON] [-p]

```

* This will walk through FROM_FOLDER and find all files with .bag as extension, then extract.
* If the end timestamp of extracted bag BAG1 in TO_FOLDER are close to the start timestamp of unprocessed bag BAG2, they will be merged into BAG1
* This Program can be stopped or terminated at any time. It will resume from the last progress.
* Arguments:
	* Default value of FROM_FOLDER is downloaded_bags, which means you can simply put the bag in downloaded_bags/. Another option is to set FROM_FOLDER to /media/[USER_NAME]/[DRIVE_NAME]/.
	* Default value of TO_FOLDER is processed_bags. Another option is to set TO_FOLDER to /media/[USER_NAME]/[DRIVE_NAME]/processed.
	* Default value of RECORD_JSON is bag_process_record.json. Another option is to set RECORD_JSON to /media/[USER_NAME]/[DRIVE_NAME]/processed/record.json.
	* -p option will only check if there's any bag that was terminated unexpectedly, then fix the record file and 
