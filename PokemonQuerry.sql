--1.Đếm số lượng Pokemon mà mỗi nhà huấn luyện đang sở hữu,chỉ hiện những người
--có Pokemon có độ hiếm từ 3 trở lên và sắp xếp theo thứ tự tổng số pokemon giảm dần 
SELECT 
    n.TenNHL AS 'Nhà huấn luyện',
    COUNT(CASE WHEN p.DoHiem >= 3 THEN 1 END) AS 'Số Pokemon hiếm',
    COUNT(p.MaPokemon) AS 'Tổng số Pokemon'
FROM NhaHuanLuyen n
JOIN PokeBall pb ON pb.MaNHL = n.MaNHL
JOIN Pokemon p ON pb.MaPokemon = p.MaPokemon
GROUP BY n.TenNHL
HAVING COUNT(CASE WHEN p.DoHiem >= 3 THEN 1 END) > 0
ORDER BY COUNT(p.MaPokemon) DESC;

--2.Đếm số lượng Pokémon theo độ hiếm từ 2 trờ lên ,sắp xếp theo thứ tự giảm dần 
SELECT DoHiem, COUNT(*) AS SoLuong
FROM Pokemon
WHERE DoHiem >= 2
GROUP BY DoHiem
HAVING COUNT(*) > 0
ORDER BY SoLuong DESC;

--3. Đếm số lượng Pokémon theo độ hiếm, chỉ lấy các độ hiếm có trung bình chỉ số lớn hơn mức trung bình chung
SELECT DoHiem, COUNT(*) AS SoLuong
FROM Pokemon
WHERE ChiSo IS NOT Null
GROUP BY DoHiem
HAVING AVG(ChiSo) > (
    SELECT AVG(ChiSo) FROM Pokemon
);

--4.Insert thêm hệ thường(normal)
INSERT INTO He (MaHe, TenHe)
VALUES ('HE011', 'Normal');
--Kiểm tra 
SELECT * FROM He;

--5.Update hệ 1 số pokemon thuộc hệ thường 
DELETE FROM Pokemon_He
WHERE MaPokemon = 'P005' AND MaHe = 'HE006';
UPDATE Pokemon_He
SET MaHe = 'HE011'
WHERE MaPokemon IN ('P005', 'P008', 'P009');
--Kiểm tra 
SELECT * FROM Pokemon_He;

--6.Hiển thị các hệ có số Pokémon từ 2 trở lên và có chỉ số trung bình lớn hơn chí số trung bình tất cả các Pokémon.
SELECT h.TenHe AS 'Hệ',
       COUNT(ph.MaPokemon) AS 'Số Pokémon',
       AVG(p.ChiSo) AS 'Chỉ số trung bình'
FROM He h
JOIN Pokemon_He ph ON h.MaHe = ph.MaHe
JOIN Pokemon p ON p.MaPokemon = ph.MaPokemon
WHERE p.DoHiem IS NOT NULL
GROUP BY h.TenHe
HAVING COUNT(ph.MaPokemon) >= 2
   AND AVG(p.ChiSo) > (
       SELECT AVG(ChiSo)
       FROM Pokemon
       WHERE ChiSo IS NOT Null
   )
ORDER BY [Chỉ số trung bình] DESC;

--7.Insert nội tại Rock Head
INSERT INTO NoiTai (MaNoiTai ,TenNoiTai ,MoTa)
VALUES ('NT006' ,'Rock Head' ,'Protects the Pokémon from recoil damage');
--Kiểm tra 
SELECT * FROM NoiTai;

--8.Update nội tại mới cho geodude và onix
UPDATE Pokemon
SET MaNoiTai = 'NT006'
WHERE TenPokemon IN ('Geodude', 'Onix');
--Kiểm tra
SELECT TenPokemon, MaNoiTai
FROM Pokemon
WHERE TenPokemon IN ('Geodude', 'Onix');

--9.Xóa hệ không có pokemon nào 
DELETE FROM He
WHERE NOT EXISTS (
    SELECT 1
    FROM Pokemon_He
    WHERE He.MaHe = Pokemon_He.MaHe
);

--Kiểm tra
SELECT * FROM He
WHERE NOT EXISTS (
    SELECT 1
    FROM Pokemon_He
    WHERE He.MaHe = Pokemon_He.MaHe
);

--10.Xóa những pokemon không thuộc sở hữu bởi nhà huấn luyện nào 
DELETE FROM Pokemon_He
WHERE MaPokemon NOT IN (
    SELECT MaPokemon FROM PokeBall
);
DELETE FROM Pokemon_NoiTai
WHERE MaPokemon NOT IN (
    SELECT MaPokemon FROM PokeBall
);
DELETE FROM Pokemon
WHERE MaPokemon NOT IN (
    SELECT MaPokemon FROM PokeBall
);
--Kiểm tra
SELECT * FROM Pokemon_He
WHERE MaPokemon NOT IN (
    SELECT MaPokemon FROM PokeBall
);
SELECT * FROM Pokemon_NoiTai
WHERE MaPokemon NOT IN (
    SELECT MaPokemon FROM PokeBall
);
SELECT * FROM Pokemon
WHERE MaPokemon NOT IN (
    SELECT MaPokemon FROM PokeBall
);