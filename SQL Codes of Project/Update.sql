

-- Updating faculty members information
UPDATE faculty_member
SET FPhone = "05537306080", FOffice = "Buca"
WHERE FId = 15;

-- Updating keyword for correction
UPDATE course
SET CoName = "ARTIFICIAL INTELLIGENCE METHODS"
WHERE CoName = "YAPAY ZEKA YÖNTEMLERİ";

-- Changing dean
UPDATE college
SET DeanId = 3
WHERE CName = "Ege Üniversitesi Mühendislik Fakültesi";

