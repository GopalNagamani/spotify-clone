# 🧠 Master Headshots and Flags Validation

This project is a script-based tool to **validate headshots and flags** for table tennis event participants. It integrates with WTT APIs to fetch event and participant data, download headshots, validate against CMS folders, and optionally compare faces using Azure Face API. All results are compiled into a detailed Excel report.

## Table of Contents

- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Configuration](#configuration)
- [What this script does](#what-this-script-does)
- [How to Run](#how-to-run)
- [Output](#output)
- [Face Comparison](#face-comparison)
- [Tips](#tips)
- [Example Config Snippet](#example-config-snippet)
- [Contact](#contact)

---

## 📂 Project Structure

```
.
├── config/
│   └── config_MasterHeadshotsandFlagsValidationstv0.txt
|   └── config_get_event_matchesv1
├── scripts/
    └── MasterHeadshotsandFlagsValidationstv0.py
    └── get_event_matchesv1.py
├── output/
│   └── HeadshotsandFlagsValidation_<date>.xlsx
```

---

## ⚙️ Prerequisites

* Python 3.8+
* Visual Studio 
* Install dependencies:

```bash
pip install pandas requests xlsxwriter opencv-python
```

---

## 📄 Configuration

All configuration settings are loaded from:

```
config/config_MasterHeadshotsandFlagsValidationstv0.txt
config/config_get_event_matchesv1.txt
```

### Key Configuration Fields:

* `EVENT_ID`, `MATCH_DATE`: Event ID and Match Date to validate.
* `HEADSHOT_FOLDER`, `FLAG_FOLDER`, `OUTPUT_FOLDER`: Local directories for validation and output.
* `participantsurl`, `getmatchesurl`, `incremental_headshotsurl`: WTT API endpoints.
* `AZURE_FACE_API_KEY`, `AZURE_FACE_API_ENDPOINT`: Azure Face API for optional image comparison.
* `download_mode`: `F` (Full headshot download) or `I` (Incremental).
* `do_face_compare`: Set to `yes` to enable Azure Face comparison.

---

## 💡 What this script does

### 1. Download and Validate Assets (`MasterHeadshotsandFlagsValidationstv0.py`)

Main script to:

* Update `isQuailifier = True` if going to validate headshots for qualifying draw matches, `isQuailifier = False` if going to validate headshots for main draw matches
* Fetch participants
* Download headshots (Full or Incremental)
* Fetch matches
* Validate presence of headshots and flags
* (Optional) Perform face comparison using Azure Face API
* Export results to Excel

Ensure your configuration file (`config_*.txt`) is named appropriately to match the script name.


## 🚀 How to Run

* Install Validator App
* Run ```MasterHeadshotsandFlagsValidations``` to download headshots from server
* Run ```get_event_matchesv1``` to compare headshots for the event

---

## 📊 Output

A `.xlsx` file is generated in the specified `OUTPUT_FOLDER`. It contains:

* `participants`: All players fetched from participants API
* `MatchesToday`: Matches for the specified date
* `hs_<tag>`: Headshot validation (R and L images)
* `flg_<tag>`: Flag presence validation
* Optional face comparison confidence and match status columns

---

## 🧪 Face Comparison (Optional)

If `do_face_compare=yes`, the script will:

* Use Azure Face API to detect and compare faces
* Provide match confidence score between CMS and headshot folder images

---

## 🛠 Tips

* Ensure API keys and tokens are valid and not expired.
* Folder paths must exist and be accessible.
* Excel sheet names are truncated to a max of 31 characters to avoid errors.

---

## 📝 Example Config Snippet

```txt
EVENT_ID = 3058
MATCH_DATE = 2025-06-05
HEADSHOT_FOLDER = C:\path\to\headshots
FLAG_FOLDER = C:\path\to\flags
OUTPUT_FOLDER = C:\path\to\output
download_mode =F
do_face_compare=yes
AZURE_FACE_API_KEY = your_key_here
AZURE_FACE_API_ENDPOINT = https://your_endpoint/
```

---

## 📬 Contact

WTT contact details 

---
