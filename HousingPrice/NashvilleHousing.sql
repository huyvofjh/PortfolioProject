-- CLEANSING DATA IN SQL QUERIES 
SELECT * FROM PortfolioProject..NashvilleHousing
-----------------------------------------------------------------------------------

-- STANDARD DATE FORMAT 
ALTER TABLE NashvilleHousing -- Add column SaleDateConveted
ADD SaleDateConverted DATE

UPDATE NashvilleHousing -- Update Table 
SET SaleDateConverted = CONVERT(DATE,SaleDate)

ALTER TABLE NashvilleHousing -- Delete column SaleDate
DROP COLUMN SaleDate

------------------------------------------------------------------------------------

-- POPULATE PROPERTY ADDRESS DATA 
SELECT PropertyAddress FROM PortfolioProject..NashvilleHousing
WHERE PropertyAddress IS NULL

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, -- Self Join PropertyAddress Column 
ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b 
ON a.ParcelID = b.ParcelID 
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress) -- Update Table
FROM PortfolioProject..NashvilleHousing a
JOIN PortfolioProject..NashvilleHousing b 
ON a.ParcelID = b.ParcelID 
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

---------------------------------------------------------------------------------------
-- BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMN (ADDRESS, CITY, STATE) 

SELECT * FROM PortfolioProject..NashvilleHousing

-- PropertyAddress Coloumn 
SELECT SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) AS Address, -- Split comma in PropertyAddress Column 
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)-CHARINDEX(',',PropertyAddress)) AS City
FROM PortfolioProject..NashvilleHousing

ALTER TABLE NashvilleHousing  -- Add PropertySplitAddress Column 
ADD PropertySplitAddress NVARCHAR(100)

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)

ALTER TABLE NashvilleHousing -- Add PropertySplitCity Column 
ADD PropertySplitCity NVARCHAR(100)

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1,LEN(PropertyAddress)-CHARINDEX(',',PropertyAddress)) 

ALTER TABLE NashvilleHousing  -- Delete PropertyAddress Colun 
DROP COLUMN PropertyAddress


-----------------------------------------------------------
SELECT * FROM PortfolioProject..NashvilleHousing

-- OwnerAddress Column 
SELECT PARSENAME(REPLACE(OwnerAddress,',','.'),3) AS OwnerSplitAddress,
PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS OwnerSplitCity,
PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS OwnerSplitState
FROM PortfolioProject..NashvilleHousing

ALTER TABLE PortfolioProject..NashvilleHousing
ADD OwnerSplitAddress VARCHAR(50)

UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE PortfolioProject..NashvilleHousing 
ADD OwnerSplitCity VARCHAR(50)

UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE PortfolioProject..NashvilleHousing
ADD OwnerSplitState VARCHAR(50)

UPDATE PortfolioProject..NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'),1)

------------------------------------------------------------------------------

-- CHANGE Y AND N TO YES AND NO IN "Sold As Vacant" field 
SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant) FROM PortfolioProject..NashvilleHousing
GROUP BY SoldAsVacant

SELECT CASE WHEN SoldAsVacant = 'N' THEN 'No'
			WHEN SoldAsVacant = 'Y' THEN 'Yes'
			ELSE SoldAsVacant
			END
FROM PortfolioProject..NashvilleHousing

UPDATE PortfolioProject..NashvilleHousing
SET SoldAsVacant =  CASE WHEN SoldAsVacant = 'N' THEN 'No'
						 WHEN SoldAsVacant = 'Y' THEN 'Yes'
						 ELSE SoldAsVacant
						 END

--------------------------------------------------------------------------------------------

-- Remove Duplicates
SELECT * FROM PortfolioProject..NashvilleHousing

-- Shows Duplicates Values 
SELECT ParcelID,PropertyAddress, SalePrice, LegalReference, OwnerName,SaleDateConverted,COUNT(*) FROM PortfolioProject..NashvilleHousing
GROUP BY ParcelID,PropertyAddress, SalePrice, LegalReference, OwnerName,SaleDateConverted
HAVING COUNT(*) > 1

-- Shows Duplicates Values 
WITH RowNumCTE AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SalePrice, LegalReference, SaleDateConverted ORDER BY UniqueID DESC) AS RowNum
FROM PortfolioProject..NashvilleHousing
)
SELECT * FROM RowNumCTE
WHERE RowNum > 1

SELECT * FROM PortfolioProject..NashvilleHousing

DELETE FROM PortfolioProject..NashvilleHousing WHERE [UniqueID ]IN (
SELECT a.[UniqueID ] FROM  PortfolioProject..NashvilleHousing  a 
INNER JOIN PortfolioProject..NashvilleHousing b 
ON a.ParcelID = b.ParcelID 
AND a.PropertyAddress = b.PropertyAddress 
AND a.SalePrice = b.SalePrice 
AND a.LegalReference = b.LegalReference 
AND a.SaleDateConverted = b.SaleDateConverted 
WHERE a.[UniqueID ] < b.[UniqueID ] )

---------------------------------------------------------------------------

SELECT [UniqueID ],PropertySplitAddress, PropertySplitCity, LandUse, SaleDateConverted, YearBuilt, SoldAsVacant,
LandValue, BuildingValue, TotalValue
FROM PortfolioProject..NashvilleHousing

---------------------------------------------------------------------------

SELECT [UniqueID ], SaleDateConverted, SalePrice
FROM PortfolioProject..NashvilleHousing