# Capstone Project Spring 2024: Data Science Analysis-  Deciphering the Innovation Pipeline of Physician-Scientists

## Ashley You, class of Fall 2025
## Notes:
==> Raw data CSV's are in this google drive folder because they are too big to upload to Github:
[https://drive.google.com/drive/folders/1SOqsSAvsrcSaipynXAbk2A-OkFWVRudL?usp=drive_link]

## Sources:
~ Names of Physician-Scientists that were easily accessible and credible were webscraped from The American Society for Clinical Investigation:
[ASCI](https://data.the-asci.org/controllers/asci/DirectoryController.php?action=home) <br />
~ Grants, Clinical Trials, and Patents created by these physicians were queried with the DimensionAI Database: [DimensionsAI](https://app.dimensions.ai)
~ Publications were queried with the OpenAlex Database:[DimensionsAI](https://openalex.org/)

### Methods:
1. Collect names of physician-scientists <br />
 a) Webscrape list of names from the ASCI induction year 1995 and 2010 <br />
 b) Organized the list of names and associate institutions and specialties in a CSV <br />
 c) keep names in CSV file called 1995_2010_details.csv <br />

2. Collect CSV's for trials, patents, publications, and grants  <br />
  a) Queried DimensionsAI and OpenAlex for Ids associated with the list of ASCI names <br />
  b) Looked over the list of Ids outputted for each name and manually disambiguated and chose the right Id(s) for each person <br />
  c) Queried each database with the associated name Id and saved the raw data into JSON files <br />
  d) Converted JSON files to CSV files <br />

3. Cleaned the CSV files that contained outputs (Clinical Trials, Patents, Grants, Publications) <br />
  a) CSV files contained duplicates from the queries, so I removed duplicated rows <br />
  b) Unicode was found in some titles, so I filtered each title to reflect the alphabet <br />


