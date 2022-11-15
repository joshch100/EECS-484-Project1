INSERT INTO USERS (USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER)
SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER
FROM project1.PUBLIC_USER_INFORMATION;

/* need to deal with (a,b) and (b,a) */
INSERT INTO FRIENDS (USER1_ID, USER2_ID)
SELECT DISTINCT USER1_ID, USER2_ID 
FROM project1.PUBLIC_ARE_FRIENDS;

INSERT INTO CITIES (CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO CITIES (CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY
FROM project1.PUBLIC_USER_INFORMATION;

INSERT INTO CITIES (CITY_NAME, STATE_NAME, COUNTRY_NAME)
SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY
FROM project1.PUBLIC_EVENT_INFORMATION;

INSERT INTO USER_CURRENT_CITIES (USER_ID, CURRENT_CITY_ID)
SELECT DISTINCT K.USER_ID, G.CITY_ID
FROM project1.PUBLIC_USER_INFORMATION K 
INNER JOIN CITIES G
ON ((K.CURRENT_CITY = G.CITY_NAME)
AND (K.CURRENT_COUNTRY = G.COUNTRY_NAME)
AND (K.CURRENT_STATE = G.STATE_NAME));


INSERT INTO USER_HOMETOWN_CITIES (USER_ID, HOMETOWN_CITY_ID)
SELECT DISTINCT K.USER_ID, G.CITY_ID
FROM project1.PUBLIC_USER_INFORMATION K 
INNER JOIN CITIES G
ON ((K.HOMETOWN_CITY = G.CITY_NAME)
AND (K.HOMETOWN_STATE = G.STATE_NAME)
AND (K.HOMETOWN_COUNTRY = G.COUNTRY_NAME));


INSERT INTO USER_EVENTS (EVENT_ID, EVENT_CREATOR_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_ADDRESS, EVENT_CITY_ID, EVENT_START_TIME, EVENT_END_TIME)
SELECT DISTINCT K.EVENT_ID, K.EVENT_CREATOR_ID, K.EVENT_NAME, K.EVENT_TAGLINE, K.EVENT_DESCRIPTION, K.EVENT_HOST, K.EVENT_TYPE, K.EVENT_SUBTYPE, K.EVENT_ADDRESS, G.CITY_ID, K.EVENT_START_TIME, K.EVENT_END_TIME
FROM project1.PUBLIC_EVENT_INFORMATION K
INNER JOIN CITIES G
ON ((K.EVENT_CITY = G.CITY_NAME)
AND (K.EVENT_STATE = G.STATE_NAME)
AND (K.EVENT_COUNTRY = G.COUNTRY_NAME)); 


INSERT INTO PROGRAMS (INSTITUTION, CONCENTRATION, DEGREE)
SELECT DISTINCT INSTITUTION_NAME, PROGRAM_CONCENTRATION, PROGRAM_DEGREE
FROM project1.PUBLIC_USER_INFORMATION
WHERE INSTITUTION_NAME IS NOT NULL;


INSERT INTO EDUCATION (USER_ID, PROGRAM_ID, PROGRAM_YEAR)
SELECT DISTINCT PINFO.USER_ID, PGS.PROGRAM_ID, PINFO.PROGRAM_YEAR
FROM project1.PUBLIC_USER_INFORMATION PINFO INNER JOIN PROGRAMS PGS
ON PINFO.INSTITUTION_NAME = PGS.INSTITUTION
AND PINFO.PROGRAM_CONCENTRATION = PGS.CONCENTRATION
AND PINFO.PROGRAM_DEGREE = PGS.DEGREE;

SET AUTOCOMMIT OFF;

INSERT INTO ALBUMS (ALBUM_ID, ALBUM_OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID)
SELECT DISTINCT ALBUM_ID, OWNER_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, COVER_PHOTO_ID
FROM project1.PUBLIC_PHOTO_INFORMATION;


INSERT INTO PHOTOS (PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK)
SELECT DISTINCT PHOTO_ID, ALBUM_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK
FROM project1.PUBLIC_PHOTO_INFORMATION;


COMMIT;
SET AUTOCOMMIT ON;

INSERT INTO TAGS (TAG_PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X, TAG_Y)
SELECT DISTINCT PHOTO_ID, TAG_SUBJECT_ID, TAG_CREATED_TIME, TAG_X_COORDINATE, TAG_Y_COORDINATE
FROM project1.PUBLIC_TAG_INFORMATION;