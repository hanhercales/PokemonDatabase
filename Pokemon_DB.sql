
CREATE DATABASE Pokemon;
GO

USE Pokemon;
GO

-- Bảng Hệ
CREATE TABLE [dbo].[He](
    [MaHe] VARCHAR(10) NOT NULL,
    [TenHe] VARCHAR(50) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaHe] ASC)
);
GO

-- Bảng Nội Tại
CREATE TABLE [dbo].[NoiTai](
    [MaNoiTai] VARCHAR(10) NOT NULL,
    [TenNoiTai] VARCHAR(100) NOT NULL,
    [MoTa] VARCHAR(255) NULL,
    PRIMARY KEY CLUSTERED ([MaNoiTai] ASC)
);
GO

-- Bảng Chiêu Thức
CREATE TABLE [dbo].[ChieuThuc](
    [MaCT] VARCHAR(10) NOT NULL,
    [TenCT] VARCHAR(100) NOT NULL,
    [MoTa] VARCHAR(255) NULL,
    [ChiSo] INT NULL,
    [MaHe] VARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaCT] ASC)
);
GO

-- Bảng Nhà Huấn Luyện
CREATE TABLE [dbo].[NhaHuanLuyen](
    [MaNHL] VARCHAR(10) NOT NULL,
    [TenNHL] VARCHAR(100) NOT NULL,
    [Tuoi] TINYINT NOT NULL,
    [QueQuan] VARCHAR(100) NULL,
    PRIMARY KEY CLUSTERED ([MaNHL] ASC)
);
GO

-- Bảng Pokemon
CREATE TABLE [dbo].[Pokemon](
    [MaPokemon] VARCHAR(10) NOT NULL,
    [TenPokemon] VARCHAR(100) NOT NULL,
    [MoTa] VARCHAR(255) NULL,
    [ChiSo] INT NULL,
    [MaNoiTai] VARCHAR(10) NULL,
    [DoHiem] TINYINT NULL,
    [MaTienHoa] VARCHAR(10) NULL,
    PRIMARY KEY CLUSTERED ([MaPokemon] ASC)
);
GO

-- Bảng PokeBall
CREATE TABLE [dbo].[PokeBall](
    [MaBall] VARCHAR(10) NOT NULL,
    [TenBall] VARCHAR(100) NOT NULL,
    [MoTa] VARCHAR(255) NULL,
    [MaNHL] VARCHAR(10) NOT NULL,
    [MaPokemon] VARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaBall] ASC)
);
GO

-- Bảng Quan hệ nhiều-nhiều: Pokemon - Hệ
CREATE TABLE [dbo].[Pokemon_He](
    [MaPokemon] VARCHAR(10) NOT NULL,
    [MaHe] VARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaPokemon], [MaHe])
);
GO

-- Bảng Quan hệ nhiều-nhiều: Pokemon - Nội Tại
CREATE TABLE [dbo].[Pokemon_NoiTai](
    [MaPokemon] VARCHAR(10) NOT NULL,
    [MaNoiTai] VARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaPokemon], [MaNoiTai])
);
GO

-- Bảng Quan hệ nhiều-nhiều: Pokemon - Chiêu Thức
CREATE TABLE [dbo].[Pokemon_ChieuThuc](
    [MaPokemon] VARCHAR(10) NOT NULL,
    [MaCT] VARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaPokemon], [MaCT])
);
GO

-- Bảng Quan hệ: Pokemon khắc chế theo Hệ
CREATE TABLE [dbo].[KhacChe](
    [MaPokemon] VARCHAR(10) NOT NULL,
    [MaPokemonBiKhacChe] VARCHAR(10) NOT NULL,
    PRIMARY KEY CLUSTERED ([MaPokemon], [MaPokemonBiKhacChe])
);
GO

-- Bảng Tiến Hóa (Evolutions)
CREATE TABLE [dbo].[TienHoa](
    [MaPokemon] VARCHAR(10) NOT NULL, -- Mã Pokemon
    [MaTienHoa] VARCHAR(10) NULL,     -- Mã Tiến Hóa (Pokemon tiến hóa)
)
GO


-- FOREIGN KEY CONSTRAINTS
ALTER TABLE [dbo].[ChieuThuc] ADD CONSTRAINT [FK_ChieuThuc_He]
    FOREIGN KEY([MaHe]) REFERENCES [dbo].[He] ([MaHe]);
GO

ALTER TABLE [dbo].[PokeBall] ADD CONSTRAINT [FK_PokeBall_Pokemon]
    FOREIGN KEY([MaPokemon]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

ALTER TABLE [dbo].[PokeBall] ADD CONSTRAINT [FK_PokeBall_NHL]
    FOREIGN KEY([MaNHL]) REFERENCES [dbo].[NhaHuanLuyen] ([MaNHL]);
GO

ALTER TABLE [dbo].[Pokemon_He] ADD CONSTRAINT [FK_Pokemon_He_Pokemon]
    FOREIGN KEY([MaPokemon]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

ALTER TABLE [dbo].[Pokemon_He] ADD CONSTRAINT [FK_Pokemon_He_He]
    FOREIGN KEY([MaHe]) REFERENCES [dbo].[He] ([MaHe]);
GO

ALTER TABLE [dbo].[Pokemon_NoiTai] ADD CONSTRAINT [FK_Pokemon_NoiTai_Pokemon]
    FOREIGN KEY([MaPokemon]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

ALTER TABLE [dbo].[Pokemon_NoiTai] ADD CONSTRAINT [FK_Pokemon_NoiTai_NoiTai]
    FOREIGN KEY([MaNoiTai]) REFERENCES [dbo].[NoiTai] ([MaNoiTai]);
GO

ALTER TABLE [dbo].[Pokemon_ChieuThuc] ADD CONSTRAINT [FK_Pokemon_ChieuThuc_Pokemon]
    FOREIGN KEY([MaPokemon]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

ALTER TABLE [dbo].[Pokemon_ChieuThuc] ADD CONSTRAINT [FK_Pokemon_ChieuThuc_ChieuThuc]
    FOREIGN KEY([MaCT]) REFERENCES [dbo].[ChieuThuc] ([MaCT]);
GO

ALTER TABLE [dbo].[Pokemon] ADD CONSTRAINT [FK_Pokemon_TienHoa]
    FOREIGN KEY([MaTienHoa]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

ALTER TABLE [dbo].[KhacChe] ADD CONSTRAINT [FK_KhacChe_Pokemon1]
    FOREIGN KEY([MaPokemon]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

ALTER TABLE [dbo].[KhacChe] ADD CONSTRAINT [FK_KhacChe_Pokemon2]
    FOREIGN KEY([MaPokemonBiKhacChe]) REFERENCES [dbo].[Pokemon] ([MaPokemon]);
GO

-- =======================
-- BẢNG HỆ (TYPES)
-- =======================
INSERT INTO He VALUES
('HE001', 'Fire'),
('HE002', 'Water'),
('HE003', 'Grass'),
('HE004', 'Electric'),
('HE005', 'Psychic'),
('HE006', 'Dark'),
('HE007', 'Rock'),
('HE008', 'Flying'),
('HE009', 'Ice'),
('HE010', 'Poison');

-- =======================
-- BẢNG NỘI TẠI (ABILITIES)
-- =======================
INSERT INTO NoiTai VALUES
('NT001', 'Flame Body', 'Reduces damage from Fire-type attacks'),
('NT002', 'Regenerator', 'Restores 10% HP each turn'),
('NT003', 'Freezing Aura', 'Chance to paralyze the opponent'),
('NT004', 'Light Boost', 'Increases critical hit rate'),
('NT005', 'Water Absorb', NULL);

-- =======================
-- BẢNG CHIÊU THỨC (MOVES)
-- =======================
INSERT INTO ChieuThuc VALUES
('CT001', 'Ember', 'Burns the target', 40, 'HE001'),
('CT002', 'Water Gun', 'Water blast', 45, 'HE002'),
('CT003', 'Razor Leaf', 'Sharp-edged leaves attack', 35, 'HE003'),
('CT004', 'Thunder Shock', 'Electric shock', 50, 'HE004'),
('CT005', 'Rock Throw', 'Throws rocks', 40, 'HE007'),
('CT006', 'Psychic', 'Illusory psychic attack', 55, 'HE005');

-- =======================
-- BẢNG NHÀ HUẤN LUYỆN (TRAINERS)
-- =======================
INSERT INTO NhaHuanLuyen VALUES
('NHL001', 'Ash', 15, 'Pallet'),
('NHL002', 'Misty', 16, 'Cerulean'),
('NHL003', 'Brock', 17, 'Pewter'),
('NHL004', 'Gary', 18, 'Pallet'),
('NHL005', 'Erika', 19, 'Celadon'),
('NHL006', 'Lt. Surge', 21, 'Vermilion'),
('NHL007', 'Sabrina', 22, 'Saffron');

-- =======================
-- BẢNG POKÉMON
-- =======================
INSERT INTO Pokemon VALUES
('P001', 'Charmander', 'Small fire lizard', 39, 'NT001', 2, NULL),
('P002', 'Squirtle', 'Water turtle', 44, 'NT005', 2, NULL),
('P003', 'Bulbasaur', 'Dinosaur with a plant', 45, 'NT002', 3, NULL),
('P004', 'Pikachu', 'Electric mouse', 35, 'NT004', 3, NULL),
('P005', 'Eevee', 'Tiny evolution creature', 40, NULL, 4, NULL),
('P006', 'Geodude', 'Rock with arms', 40, NULL, 3, NULL),
('P007', 'Pidgey', 'Tiny bird', 40, NULL, 3, NULL),
('P008', 'Jigglypuff', 'Balloon Pokémon', 60, NULL, 3, NULL),
('P009', 'Meowth', 'Talking cat', 35, NULL, 2, NULL),
('P010', 'Psyduck', 'Confused duck', 50, 'NT003', 2, NULL),
('P011', 'Growlithe', 'Loyal puppy', 45, 'NT001', 2, NULL),
('P012', 'Vulpix', 'Six-tailed fox', 38, 'NT001', 2, NULL),
('P013', 'Machop', 'Fighter Pokémon', 50, NULL, 2, NULL),
('P014', 'Abra', 'Sleeping psychic', 30, 'NT004', 2, NULL),
('P015', 'Gastly', 'Gaseous ghost', 30, 'NT003', 2, NULL),
('P016', 'Onix', 'Rock snake', 55, NULL, 2, NULL),
('P017', 'Oddish', 'Walking weed', 35, NULL, 2, NULL),
('P018', 'Poliwag', 'Tadpole Pokémon', 40, NULL, 2, NULL),
('P019', 'Sandshrew', 'Sand mouse', 45, NULL, 2, NULL),
('P020', 'Cubone', 'Lonely Pokémon', 50, NULL, 2, NULL);

-- =======================
-- BẢNG POKÉBALLS
-- =======================
INSERT INTO PokeBall VALUES
('PB001', 'Poké Ball', 'Standard ball', 'NHL001', 'P001'),
('PB002', 'Poké Ball', 'Standard ball', 'NHL001', 'P004'),
('PB003', 'Great Ball', 'Better catch rate', 'NHL002', 'P002'),
('PB004', 'Ultra Ball', 'High performance ball', 'NHL003', 'P003'),
('PB005', 'Master Ball', 'Guaranteed catch', 'NHL004', 'P005'),
('PB006', 'Poké Ball', 'Standard ball', 'NHL005', 'P006'),
('PB007', 'Great Ball', 'Better catch rate', 'NHL006', 'P007'),
('PB008', 'Ultra Ball', 'High performance ball', 'NHL007', 'P008');

-- =======================
-- BẢNG POKÉMON_HE
-- =======================
INSERT INTO Pokemon_He VALUES
('P001', 'HE001'),
('P002', 'HE002'),
('P003', 'HE003'),
('P004', 'HE004'),
('P005', 'HE005'),
('P005', 'HE006'),
('P006', 'HE007'),
('P007', 'HE008'),
('P008', 'HE005'),
('P009', 'HE006'),
('P010', 'HE002'),
('P011', 'HE001'),
('P012', 'HE001'),
('P013', 'HE007'),
('P014', 'HE005'),
('P015', 'HE006'),
('P016', 'HE007'),
('P017', 'HE003'),
('P018', 'HE002'),
('P019', 'HE009'),
('P020', 'HE007');

-- =======================
-- BẢNG POKÉMON_NOITAI
-- =======================
INSERT INTO Pokemon_NoiTai VALUES
('P001', 'NT001'),
('P002', 'NT005'),
('P003', 'NT002'),
('P004', 'NT004'),
('P010', 'NT003'),
('P011', 'NT001'),
('P012', 'NT001');

-- =======================
-- BẢNG POKÉMON_CHIEUTHUC
-- =======================
INSERT INTO Pokemon_ChieuThuc VALUES
('P001', 'CT001'),
('P002', 'CT002'),
('P003', 'CT003'),
('P004', 'CT004'),
('P005', 'CT006'),
('P003', 'CT005');

-- =======================
-- BẢNG KHẮC CHẾ
-- =======================
INSERT INTO KhacChe VALUES
('P001', 'P003'),
('P002', 'P001'),
('P003', 'P002'),
('P004', 'P005');

-- =======================
-- BẢNG TIẾN HÓA (EVOLUTIONS)
-- =======================
INSERT INTO TienHoa VALUES
('P001', 'P021'), -- Charmander -> Charmeleon
('P002', 'P022'), -- Squirtle -> Wartortle
('P003', 'P023'), -- Bulbasaur -> Ivysaur
('P004', 'P024'), -- Pikachu -> Raichu
('P005', 'P025'); -- Eevee -> Vaporeon
