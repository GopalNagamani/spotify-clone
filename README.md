# 🧠 Master Headshots and Flags Validation

This project is a script-based tool to **validate headshots and flags** for table tennis event participants. It integrates with WTT APIs to fetch event and participant data, download headshots, validate against CMS folders, and optionally compare faces using Azure Face API. All results are compiled into a detailed Excel report.

## Table of Contents

* [📂 Project Structure](#-📂-project-structure)
* [📦 Prerequisites](#-📦-prerequisites)
* [📄 Configuration](#-📄-configuration)
* [🔐 Authorization](#-🔐-authorization)
* [📜 Log](#-📜-log)
* [💡 What this script does](#-💡-what-this-script-does)
* [🚀 How to Run](#-🚀-how-to-run)
* [📊 Output](#-📊-output)
* [🧪 Face Comparison](#-🧪-face-comparison)
* [🛠 Tips](#-🛠-tips)
* [📝 Example Config Snippet](#-📝-example-config-snippet)
  

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

## 📦 Requirements

* Python 3.8+
* .Net runtime 9.0 or higher
* Required packages:

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

## 🔐 Authorization

Before running any validation scripts, users must **log in using their Microsoft account** through the desktop application interface. This ensures only authorized users from your organization can access and execute sensitive operations like API calls and face comparisons.

### How It Works:

* When the desktop application (`ScriptRunnerApp.exe`) is launched, it prompts the user to authenticate via **Microsoft Single Sign-On (SSO)**.
* This helps in **tracking script execution history**, ensuring **accountability**, and **restricting access** to approved personnel only.
* This login is a **prerequisite** before running any scripts listed in the app.

---

## 📜 Log

The script logs useful metadata about each execution. This helps in auditing and debugging. Logged info includes:

* User who executed the script
* Script name
* Timestamp of execution
* Any runtime errors (if any)

### Sample Log Output:

```text
Logged in User: krishnamurthy.manjini@theoptimum.net
Script Run: config_face_comparev1.py
Timestamp: 2025-06-23 15:18:45
****************************************
python: can't open file 'C:\\Users\\Gopal Nagamani\\ScriptRunnerApp_23Jun2025\\ScriptRunnerApp\\bin\\Debug\\net6.0-windows\\C\\Users\\Gopal Nagamani\\ScriptRunnerApp_23Jun2025\\ScriptRunnerApp\\bin\\Debug\\net6.0-windows\\scripts\\config_face_comparev1.py': [Errno 2] No such file or directory
****************************************
```

Logs are usually printed in the console and optionally can be redirected to a log file by modifying the script.

---

## 💡 What this script does

### 1. Download and Validate Assets (`MasterHeadshotsandFlagsValidationstv0.py`)

Main script to:

* Fetch participants
* Download headshots (Full or Incremental)
* Fetch matches
* Validate presence of headshots and flags
* Perform face comparison using Azure Face API, based on the configuration set.
* Export results to Excel

Ensure your configuration file (`config_*.txt`) is named appropriately to match the script name.

---

## 🚀 How to Run

* Run ScriptRunnerApp.exe app
* You can able to see and run multiple validations options under Scripts
* You can able to see multiple configurations already added. Update the path based on your system where the files located.

---

## 📊 Output

A `.xlsx` file is generated in the specified `OUTPUT_FOLDER`. It contains:

* `participants`: All players fetched from participants API
* `MatchesToday`: Matches for the specified date
* `playerslist`: Players list for the matches scheduled today
* `hs_<tag>`: Headshot validation (R and L images)
* `flg_<tag>`: Flag presence validation
* Optional face comparison confidence and match status columns
* Under `hs_<tag>`: sheet we have 2 columns `Headshot_R` and `Headshot_L`. These columns will return:

  * `'yes'` if the headshot is present
  * `'no'` if the headshot is missing
  * `'Incorrect Dimensions'` if the image resolution is wrong
  * `'0 kB'` if the image is corrupted

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
