# SQL_data_cleaning_project_NashvilleHousing
# Nashville Housing Data SQL Project

This repository contains a series of SQL scripts aimed at cleaning, transforming, and analyzing a dataset on housing data from Nashville. 

## Overview

The Nashville housing dataset contains information about property sales, including details about the property's address, the sale date, the sale price, and more. The scripts in this repository are designed to:

1. **Standardize Date Formats:** Transform inconsistent date formats to a uniform MySQL date format.
2. **Populate Missing Data:** Address missing property address values by leveraging other rows in the dataset.
3. **Break Addresses into Columns:** Split the full address into individual columns like `PropertySplitAddress`, `PropertySplitCity`, etc., to facilitate easier analysis.
4. **Change Data Values:** Convert shorthand notations like 'Y' and 'N' in the `SoldAsVacant` field to 'Yes' and 'No', respectively.
5. **Remove Duplicates:** Identify and delete duplicate rows based on specific criteria.
6. **Remove Unused Columns:** Delete columns that aren't necessary for the analysis to create a cleaner dataset.

## Files

- **queries.sql**: Contains all SQL queries to perform the aforementioned tasks.

## How to Use

1. Clone this repository.
2. Import your dataset into your MySQL environment. The scripts assume your dataset is named `NashvilleHousing`.
3. Execute the SQL scripts provided in the `queries.sql` file in the order they are presented.

## Queries Breakdown

1. **Standard Date Format**: Converts any string date format to the MySQL standard date format.
   
2. **Populate Property Address Data**: For properties with a missing address, it fetches the address from another record with the same parcel ID.

3. **Breaking Address into Individual Columns**: 
    - `PropertySplitAddress` contains the property's street address.
    - `PropertySplitCity` contains the city of the property.

4. **Change 'Y' and 'N' to 'Yes' and 'No'**: The script transforms shorthand notations in the `SoldAsVacant` column.

5. **Remove Duplicates**: This part identifies duplicate rows based on `ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate`, and `LegalReference` and deletes them, ensuring the dataset's uniqueness.

6. **Delete Unused Columns**: Removes `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, and `SaleDate` columns from the dataset.

## Contribution

Feel free to fork this repository and make improvements or provide any feedback to optimize the SQL scripts further.

## License

This project is open source and available under the MIT License. 

---

**Note**: Always backup your data and test scripts in a controlled environment before applying them to a production database.
