-- 1. Pokémon có CHISO > 60 --
select * from POKEMON
where CHISO > 60;

-- 2. Chiêu thức có CHISO > 40 --
select * from CHIEUTHUC
where CHISO > 40;

-- 3. Pokémon và hệ 'Electric' --
select P.TENPOKEMON, H.TENHE
from POKEMON P
join POKEMON_HE PH on P.MAPOKEMON = PH.MAPOKEMON
join HE H on PH.MAHE = H.MAHE
where H.TENHE = 'Electric';

-- 4. Pokémon có nội tại chứa 'Over' --
select P.TENPOKEMON, N.TENNOITAI
from POKEMON P
join NOITAI N on P.MANOITAI = N.MANOITAI
where N.TENNOITAI like '%Over%';

-- 5. Huấn luyện viên có Pokémon độ hiếm >= 2 --
select NHL.TENNHL, P.TENPOKEMON
from NHAHUANLUYEN NHL
join POKEBALL PB on NHL.MANHL = PB.MANHL
join POKEMON P on PB.MAPOKEMON = P.MAPOKEMON
where P.DOHIEM >= 2;

-- 6. Đếm Pokémon theo độ hiếm (> 50) --
select DOHIEM, count(*) as SOLUONG
from POKEMON
where CHISO > 50
group by DOHIEM;

-- 7. Đếm chiêu thức theo chỉ số >= 30 --
select CHISO, count(*) as SOLUONGCHIEU
from CHIEUTHUC
where CHISO >= 30
group by CHISO;

-- 8. Đếm Pokémon theo hệ, chỉ hiện hệ có >1 Pokémon --
select H.TENHE, count(*) as SOLUONGPOKEMON
from POKEMON_HE PH
join HE H on PH.MAHE = H.MAHE
group by H.TENHE
having count(*) > 1;

-- 9. Đếm Pokémon theo độ hiếm, chỉ hiện độ hiếm có >1 Pokémon --
select DOHIEM, count(*) as SOLUONG
from POKEMON
where CHISO > 40
group by DOHIEM
having count(*) > 1;

-- 10. Đếm Pokémon mỗi huấn luyện viên, chỉ hiện ai có >= 2 Pokémon --
select NHL.TENNHL, count(*) as SOLUONGPOKEMON
from NHAHUANLUYEN NHL
join POKEBALL PB on NHL.MANHL = PB.MANHL
group by NHL.TENNHL
having count(*) >= 2;
