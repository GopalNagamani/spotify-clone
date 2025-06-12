
# 🏓 Match Event Headshot & Flag Validator

This Python script fetches match data for a given event and date, and validates the existence of headshot and flag image assets for participating players. It generates a neatly organized Excel report summarizing missing or available headshots and flags.

---

## 📌 Features

- ✅ Fetches event matches from the WTT API
- ✅ Validates headshot images (both left and right variants)
- ✅ Validates national flag images
- ✅ Flattens and cleans participant data from nested JSON
- ✅ Generates a multi-sheet Excel report with validation summaries

---

## ⚙️ Configuration

Before running the script, configure the `config/config_get_event_matchesv1.txt` file with the following keys:

```ini
EVENT_ID = 3058
MATCH_DATE = 2025-06-05
HEADSHOT_FOLDER = <path-to-headshot-images>
FLAG_FOLDER = <path-to-flag-images>
getmatchesurl = <API-Endpoint-URL>
auth_token_getmatchesurl = <API-Authorization-Token>
OUTPUT_FOLDER = <path-to-output-folder>
````

Make sure the filename matches the script name:

```
get_event_matchesv1.py ➝ config_get_event_matchesv1.txt
```

---

## 📦 Requirements

* Python 3.8+
* Required packages:

```bash
pip install pandas requests xlsxwriter
```

---

## 🚀 How to Run

1. Place your configuration file under the `config/` directory.
2. Ensure that headshot and flag images are in the folders specified in the config file.
3. Execute the script

---

## 🧾 Output

The script generates an Excel report in the specified `OUTPUT_FOLDER`. The file name format is:

```
HeadshotsFlagsValidation_<YYYYMMDD>.xlsx
```

### 📁 Excel File Includes:

* `MatchesToday` — Raw match data
* `hs_<date>` — Headshot validation results
* `flg_<date>` — Flag validation results

---
