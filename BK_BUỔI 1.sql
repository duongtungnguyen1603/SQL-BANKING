USE BK_Buoi1
Go
-- 1. Lập danh sách khách hàng bao gồm các thông tin sau: tên khách hàng, loại khách hàng, số giấy tờ, loại giấy tờ, ngành nghề của khách hàng.
SELECT 
    C.OWNER_NAME AS N'Tên Khách Hàng',
    CT.CUST_TYPE_NAME AS N'Loại Khách Hàng',
	IDT.ID_TYPE_CODE AS N'Số Giấy Tờ',
    IDT.ID_TYPE_NAME AS N'Loại Giấy Tờ',
    FT.FIN_TYPE_NAME AS N'Ngành Nghề'
FROM 
    CUSTOMER C
INNER JOIN CODE_CUST_TYPE CT ON C.CUST_TYPE_CODE = CT.CUST_TYPE_CODE
INNER JOIN CODE_ID_TYPE IDT ON C.ID_TYPE_CODE = IDT.ID_TYPE_CODE
INNER JOIN CODE_FIN_TYPE FT ON C.FIN_TYPE_CODE = FT.FIN_TYPE_CODE

--2. Lập danh sách khách hàng bao gồm các thông tin sau: tên khách hàng, loại khách hàng, số giấy tờ, loại giấy tờ, loại hình doanh nghiệp
SELECT 
    C.OWNER_NAME AS N'Tên Khách Hàng',
    CT.CUST_TYPE_NAME AS N'Loại Khách Hàng',
	IDT.ID_TYPE_CODE AS N'Số Giấy Tờ',
    IDT.ID_TYPE_NAME AS N'Loại Giấy Tờ',
	COR.ORG_TYPE_NAME AS N'Loại Hình Doanh Nghiệp'
FROM CUSTOMER C
INNER JOIN CODE_CUST_TYPE CT ON C.CUST_TYPE_CODE = CT.CUST_TYPE_CODE
INNER JOIN CODE_ID_TYPE IDT ON C.ID_TYPE_CODE = IDT.ID_TYPE_CODE
INNER JOIN CODE_ORG_TYPE COR ON C.ORG_TYPE_CODE = COR.ORG_TYPE_CODE

--3. Lập danh sách khách hàng của các chi nhánh ngân hàng hàng địa chỉ tại thành phố Hồ Chí Minh.
SELECT C.OWNER_NAME AS N'Tên Khách Hàng', CB.BRANCH_NAME AS N'Tên Chi Nhánh', CB.BRANCH_ADDRESS AS N'Địa Chỉ Chi Nhánh', CTY.CITY_NAME AS N'Thành Phố' 
FROM CUSTOMER C
INNER JOIN CODE_BRANCH as CB on C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_CITY AS CTY ON CB.CITY_CODE = CTY.CITY_CODE
WHERE CITY_NAME = 'HO CHI MINH'

--4. Lập danh sách doanh nghiệp trong lĩnh vực 'SỬA CHỮA' bao gồm các thông tin sau: Mã số thuế - Tên doanh nghiệp - Địa chỉ - Ngày thành lập-CMND chủ sở hữu - Tên CSH;
SELECT C.CUSTID AS [Mã Số Thuế], C.CUSTNAME AS [Tên Doanh Nghiệp], C.CUST_ADD AS [Địa Chỉ], C.ESTABLISH AS [Ngày Thành Lập], C.OWNER_ID AS [CMND CSH], C.OWNER_NAME AS [Tên CSH] FROM CUSTOMER C 
INNER JOIN CODE_FIN_TYPE CF ON C.FIN_TYPE_CODE = CF.FIN_TYPE_CODE
WHERE CF.FIN_TYPE_NAME LIKE N'%SỬA CHỮA%'

--5. Lập danh sách khách hàng của các chi nhánh ngân hàng thuộc Khu vực Đông Nam Bộ.
SELECT 
    C.CUSTID AS [Mã KH],
    C.CUSTNAME AS [Tên KH],
    CB.BRANCH_NAME AS [Tên Chi Nhánh],
    CA.AREA_NAME AS [Khu vực] 
FROM CUSTOMER C
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_AREA CA ON CB.AREA_CODE = CA.AREA_CODE
WHERE CA.AREA_NAME = 'DONG NAM BO'

--6. Lập danh sách khách hàng doanh nghiệp khu vực Đông Bắc Bộ: MST - Tên doanh nghiệp - Địa chỉ - Ngày thành lập-CMND chủ sở hữu - Tên CSH;
SELECT C.CUSTID AS [Mã Số Thuế], C.CUSTNAME AS [Tên Doanh Nghiệp], C.CUST_ADD AS [Địa Chỉ], C.ESTABLISH AS [Ngày Thành Lập], C.OWNER_ID AS [CMND CSH], C.OWNER_NAME AS [Tên CSH], CA.AREA_NAME AS [Khu Vực] FROM CUSTOMER C 
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_AREA CA ON CB.AREA_CODE = CA.AREA_CODE
WHERE CA.AREA_NAME = 'DONG BAC BO' AND C.CUST_TYPE_CODE = 'TC'

--7. Lập danh sách các đơn vị vận tải kho bãi thuộc khu vực Đông Bắc Bộ bao gồm: MST - Tên doanh nghiệp - Địa chỉ - Ngày thành lập-CMND chủ sở hữu - Tên CSH-Tỉnh thành).
SELECT C.CUSTID AS [Mã Số Thuế], C.CUSTNAME AS [Tên Doanh Nghiệp], C.CUST_ADD AS [Địa Chỉ], C.ESTABLISH AS [Ngày Thành Lập], C.OWNER_ID AS [CMND CSH], C.OWNER_NAME AS [Tên CSH], CT.CITY_NAME AS [Tỉnh/Thành phố], CA.AREA_NAME AS [Khu Vực] FROM CUSTOMER C 
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_AREA CA ON CB.AREA_CODE = CA.AREA_CODE
INNER JOIN CODE_CITY CT ON CB.CITY_CODE = CT.CITY_CODE
INNER JOIN CODE_FIN_TYPE CFT ON C.FIN_TYPE_CODE = CFT.FIN_TYPE_CODE
WHERE CA.AREA_NAME = 'DONG BAC BO' AND CFT.FIN_TYPE_NAME = N'Vận tải kho bãi'

--8. Lập danh sách các công ty tư nhân.
SELECT 
    C.CUSTID AS [Mã số thuế],
    C.CUSTNAME AS [Tên công ty],
    C.CUST_ADD AS [Địa chỉ],
    C.ESTABLISH AS [Ngày thành lập],
    C.OWNER_NAME AS [Chủ sở hữu],
    C.OWNER_ID AS [CMND CSH],
	OT.ORG_TYPE_NAME AS [Loại hình doanh nghiệp]
FROM CUSTOMER C 
INNER JOIN CODE_ORG_TYPE OT ON C.ORG_TYPE_CODE = OT.ORG_TYPE_CODE
WHERE OT.ORG_TYPE_NAME = N'Doanh nghiệp tư nhân'

--9. Lập danh sách các khách hàng tại chi nhánh Thái Bình bao gồm (Tên- Số giấy tờ - Loại giấy tờ - loại hình khách hàng (Cá nhân/doanh nghiệp) - nơi cấp giấy tờ.
SELECT 
    C.CUSTNAME AS [Tên Khách Hàng],  
    C.ID_NUMBER AS [Số Giấy Tờ],  
    CIT.ID_TYPE_NAME AS [Loại Giấy Tờ],  
    CCT.CUST_TYPE_NAME AS [Loại Hình KH],  
    CI.CITY_NAME AS [Nơi Cấp Giấy Tờ] 
FROM CUSTOMER C 
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_CITY CT ON CB.CITY_CODE = CT.CITY_CODE
INNER JOIN CODE_ID_TYPE CIT ON C.ID_TYPE_CODE = CIT.ID_TYPE_CODE
INNER JOIN CODE_CUST_TYPE CCT ON C.CUST_TYPE_CODE = CCT.CUST_TYPE_CODE
LEFT JOIN CODE_CITY CI ON C.ID_CITY = CI.CITY_CODE
WHERE CT.CITY_NAME = 'THAI BINH'

--10. Lập danh sách khách hàng của 'NH TMCP VNC  -Chi nhánh Thanh Xuân' bao gồm các thông tin: Tên khách hàng- Số giấy tờ - Loại giấy tờ - loại hình khách hàng (Cá nhân-doanh nghiệp) - nơi cấp giấy tờ-loại hình khách hàng - ngành nghề của khách hàng.
SELECT 
    C.CUSTNAME AS [Tên Khách Hàng],
    C.ID_NUMBER AS [Số Giấy Tờ],
    CIT.ID_TYPE_NAME AS [Loại Giấy Tờ],
    CCT.CUST_TYPE_NAME AS [Loại Hình KH],
    CI.CITY_NAME AS [Nơi Cấp Giấy Tờ],
    CFT.FIN_TYPE_NAME AS [Ngành Nghề KH]
FROM CUSTOMER C 
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_ID_TYPE CIT ON C.ID_TYPE_CODE = CIT.ID_TYPE_CODE
INNER JOIN CODE_CUST_TYPE CCT ON C.CUST_TYPE_CODE = CCT.CUST_TYPE_CODE
INNER JOIN CODE_FIN_TYPE CFT ON C.FIN_TYPE_CODE = CFT.FIN_TYPE_CODE
LEFT JOIN CODE_CITY CI ON C.ID_CITY = CI.CITY_CODE
WHERE CB.BRANCH_NAME = N'NH TMCP VNC  - Chi nhánh Thanh Xuân'

--11. Lập danh sách các khách hàng doanh nghiệp thành lập sau năm 2010.
SELECT * FROM CUSTOMER C
INNER JOIN CODE_CUST_TYPE CCT ON C.CUST_TYPE_CODE = CCT.CUST_TYPE_CODE
WHERE CCT.CUST_TYPE_CODE = 'TC' AND YEAR(C.ESTABLISH) > 2010

--12. Lập danh sách gồm: Mã khu vực, tên khu vực, số lượng khách hàng (sắp xếp theo số khách hàng giảm dần từ nhiều nhất đến ít nhất).
SELECT CA.AREA_CODE AS [MÃ KHU VỰC], CA.AREA_NAME AS [TÊN KHU VỰC], COUNT(C.CUSTID) AS [SỐ LƯỢNG KHÁCH HÀNG] FROM CUSTOMER C
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
INNER JOIN CODE_AREA CA ON CB.AREA_CODE = CA.AREA_CODE
GROUP BY CA.AREA_CODE, CA.AREA_NAME
ORDER BY [SỐ LƯỢNG KHÁCH HÀNG] DESC

--13. Lập danh sách gồm: Mã chi nhánh, tên chi nhánh, địa chỉ chi nhánh, số lượng khách hàng (sắp xếp theo số khách hàng giảm dần từ nhiều nhất đến ít nhất).
SELECT CB.BRANCH_CODE AS [MÃ CHI NHÁNH], CB.BRANCH_NAME AS [TÊN CHI NHÁNH], CB.BRANCH_ADDRESS AS [ĐỊA CHỈ CHI NHÁNH], COUNT(*) AS [SỐ LƯỢNG KHÁCH HÀNG]  FROM CUSTOMER C
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
GROUP BY CB.BRANCH_CODE, CB.BRANCH_ADDRESS,CB.BRANCH_NAME
ORDER BY [SỐ LƯỢNG KHÁCH HÀNG] DESC
GO

--14. Lập danh sách gồm: Mã ngành nghề, tên ngành nghề, số lượng khách hàng của mỗi ngành nghề (sắp xếp theo số khách hàng giảm dần).
SELECT CFT.FIN_TYPE_CODE AS [MÃ NGÀNH], CFT.FIN_TYPE_NAME AS [TÊN NGÀNH], COUNT(*) AS [SỐ LƯỢNG KHÁCH HÀNG] FROM CUSTOMER C
INNER JOIN CODE_FIN_TYPE CFT ON C.FIN_TYPE_CODE = CFT.FIN_TYPE_CODE
GROUP BY CFT.FIN_TYPE_CODE, CFT.FIN_TYPE_NAME
ORDER BY COUNT(*) DESC

--15. Lập danh sách gồm: Mã loại hình doanh nghiệp, tên loại hình doanh nghiệp, số lượng khách hàng (sắp xếp theo số khách hàng giảm dần).
SELECT COR.ORG_TYPE_CODE AS [MÃ LOẠI HÌNH DN], COR.ORG_TYPE_NAME AS [TÊN LOẠI HÌNH DN], COUNT(*) AS [SỐ LƯỢNG KHÁCH HÀNH] FROM CUSTOMER C
INNER JOIN CODE_ORG_TYPE COR ON C.ORG_TYPE_CODE = COR.ORG_TYPE_CODE
GROUP BY COR.ORG_TYPE_CODE, COR.ORG_TYPE_NAME
ORDER BY COUNT(*) DESC

--16. Ngân hàng VNC thường gửi quà tặng khách hàng nhân dịp sinh nhật. Bạn hãy lập danh sách các khách hàng có ngày sinh nhật (hoặc ngày thành lập đối với công ty) trong tháng 07 (và mở rộng là tháng hiện tại).
SELECT C.CUSTID AS [MÃ KHÁCH HÀNG/CTY], C.CUSTNAME AS [TÊN KHÁCH HÀNG/CTY], CB.BRANCH_NAME AS [TÊN CHI NHÁNH], C.DATE_OF_BIRTH AS [NGÀY SINH], C.ESTABLISH AS [NGÀY THÀNH LẬP], C.CUST_TYPE_CODE AS [LOẠI KHÁCH HÀNG] FROM CUSTOMER C
INNER JOIN CODE_BRANCH CB ON C.BRANCH_CODE = CB.BRANCH_CODE
WHERE (MONTH(C.DATE_OF_BIRTH) = MONTH(GETDATE()) OR MONTH(C.ESTABLISH) = MONTH(GETDATE())
OR MONTH(C.DATE_OF_BIRTH) = 7 OR MONTH(C.ESTABLISH) = 7) 
AND CB.BRANCH_NAME LIKE N'%VNC%' -- Lưu ý cho bản thân cần tách ngoặc cho or và and riêng tránh lỗi đk




