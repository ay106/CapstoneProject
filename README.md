# Capstone Project Spring 2024: Data Science Analysis-  Deciphering the Innovation Pipeline of Physician-Scientists

## Ashley You, class of Fall 2025
## Notes:
==> Raw data CSV's are in this google drive folder because they are too big to upload to Github:
[https://drive.google.com/drive/folders/1SOqsSAvsrcSaipynXAbk2A-OkFWVRudL?usp=drive_link]

### Methods:
1. Collect names of physician-scientists <br />
 a) Webscrape list of names from the ASCI induction year 1995 and 2010 <br />
 b) Organized the list of names and associate institutions and specialties in a CSV <br />
 c) keep names in CSV file called 1995_2010_details.csv <br />

2. Collect CSV's for trials, patents, publications, grants, and companies  <br />
  a) Queried DimensionsAI and OpenAlex for Ids associated with the list of ASCI names <br />
  b) Looked over the list of Ids outputted for each name and manually disambiguated and chose the right Id(s) for each person <br />
  c) Queried each database with the associated name Id and saved the raw data into JSON files <br />
  d) Converted JSON files to CSV files

3. Cleaned the CSV files that contained outputs (Clinical Trials, Patents, Grants, Publications)
  a) CSV files contained duplicates from the queries, so I removed duplicated rows
  b) Unicode was found in some titles, so I filtered each title to reflect the alphabet


