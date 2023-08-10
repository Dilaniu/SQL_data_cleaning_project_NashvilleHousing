/*

Cleaning Data in SQL Queries

*/


Select *
From NashvilleHousing;


-- Standardize Date Format


-- Assuming saleDate is of the type VARCHAR or similar
SELECT saleDateConverted, STR_TO_DATE(SaleDate, '%Y-%m-%d') 
FROM NashvilleHousing;

-- Updating saleDate
UPDATE NashvilleHousing SET SaleDate = STR_TO_DATE(SaleDate, '%Y-%m-%d');

-- If SaleDate doesn't update properly
ALTER TABLE NashvilleHousing ADD COLUMN SaleDateConverted DATE;
UPDATE NashvilleHousing SET SaleDateConverted = STR_TO_DATE(SaleDate, '%Y-%m-%d');



 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

-- Assuming you're splitting by the first comma
ALTER TABLE NashvilleHousing ADD COLUMN PropertySplitAddress VARCHAR(255);
UPDATE NashvilleHousing 
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1);

ALTER TABLE NashvilleHousing ADD COLUMN PropertySplitCity VARCHAR(255);
UPDATE NashvilleHousing 
SET PropertySplitCity = SUBSTRING(SUBSTRING_INDEX(PropertyAddress, ',', -1), 2);

--------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field

UPDATE NashvilleHousing
SET SoldAsVacant = CASE 
    WHEN SoldAsVacant = 'Y' THEN 'Yes'
    WHEN SoldAsVacant = 'N' THEN 'No'
    ELSE SoldAsVacant 
END;






-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates
-- This approach uses MySQL's variables to achieve ROW_NUMBER() functionality
SET @row_num = 0;
SET @prev_value = '';

DELETE FROM NashvilleHousing
WHERE (PropertyAddress, UniqueID) IN (
    SELECT PropertyAddress, UniqueID
    FROM (
        SELECT 
            PropertyAddress, 
            UniqueID,
            @row_num := CASE
                WHEN @prev_value = PropertyAddress THEN @row_num + 1
                ELSE 1
            END AS row_num,
            @prev_value := PropertyAddress
        FROM NashvilleHousing
        ORDER BY PropertyAddress, UniqueID
    ) AS tmp
    WHERE row_num > 1
);


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns
ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, DROP COLUMN TaxDistrict, DROP COLUMN PropertyAddress, DROP COLUMN SaleDate;

