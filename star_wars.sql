create table if not exists planets
(
	id serial not null
		constraint planets_pk
			primary key,
	name varchar,
	rotation_period integer,
	orbital_period integer,
	diameter integer,
	gravity varchar,
	surface_water integer,
	population bigint
);

alter table planets owner to postgres;

create table if not exists terrains
(
	id serial not null
		constraint terrains_pk
			primary key,
	terrain varchar
);

alter table terrains owner to postgres;

create table if not exists climates
(
	id serial not null
		constraint climates_pk
			primary key,
	climates varchar
);

alter table climates owner to postgres;

create table if not exists species
(
	id serial not null
		constraint species_pk
			primary key,
	name varchar,
	classification varchar,
	designation varchar,
	average_height integer,
	average_lifespan varchar,
	language varchar,
	homeworld_idx integer
		constraint planets_fk
			references planets
);

alter table species owner to postgres;

create table if not exists characters
(
	id serial not null
		constraint characters_pk
			primary key,
	name varchar,
	birth_year varchar,
	gender varchar,
	height integer,
	mass double precision,
	species_idx integer
		constraint species_fk
			references species,
	homeworld_idx integer
		constraint planets_fk
			references planets
);

alter table characters owner to postgres;

create table if not exists terrains_planets
(
	terrain_idx integer not null
		constraint terrains_fk
			references terrains,
	planet_idx integer not null
		constraint planets_fk
			references planets,
	constraint terrains_planets_pk
		primary key (terrain_idx, planet_idx)
);

alter table terrains_planets owner to postgres;

create table if not exists climates_planets
(
	climate_idx integer not null
		constraint climates_fk
			references climates,
	planet_idx integer not null
		constraint planets2_fk
			references planets,
	constraint climates_planets_pk
		primary key (climate_idx, planet_idx)
);

alter table climates_planets owner to postgres;

create table if not exists colors
(
	id serial not null
		constraint colors_pk
			primary key,
	color varchar
);

alter table colors owner to postgres;

create table if not exists character_colors
(
	character_idx integer not null
		constraint character_colors_fk
			references characters,
	color_idx integer not null
		constraint character_colors2_fk
			references colors,
	body_part varchar not null,
	constraint character_colors_pk
		primary key (character_idx, color_idx, body_part)
);

alter table character_colors owner to postgres;

create table if not exists species_colors
(
	species_idx integer
		constraint species_colors_fk
			references species,
	color_idx integer
		constraint species_colors2_fk
			references colors,
	body_part varchar,
	constraint species_colors_pk
		unique (species_idx, color_idx, body_part)
);

alter table species_colors owner to postgres;

create table if not exists manufacturers
(
	id serial not null
		constraint manufacturers_pk
			primary key,
	manufacturer varchar
);

alter table manufacturers owner to postgres;

create table if not exists transport_types
(
	id serial not null
		constraint transport_types_pk
			primary key,
	transport_type varchar
);

alter table transport_types owner to postgres;

create table if not exists transport_classes
(
	id serial not null
		constraint transport_classes_pk
			primary key,
	transport_class varchar,
	type_idx integer
		constraint type_fk
			references transport_types
);

alter table transport_classes owner to postgres;

create table if not exists starship_spec
(
	id serial not null
		constraint starship_spec_pk
			primary key,
	hyperdrive_rating double precision,
	megalight integer
);

alter table starship_spec owner to postgres;

create table if not exists transport_models
(
	id serial not null
		constraint transport_models_pk
			primary key,
	model varchar,
	transport_class_idx integer
		constraint class_fk
			references transport_classes,
	manufacturer_idx integer
		constraint manufacturers_fk
			references manufacturers,
	starship_spec_idx integer
		constraint starship_spec_fk
			references starship_spec
);

alter table transport_models owner to postgres;

create table if not exists transports
(
	id serial not null
		constraint transports_pk
			primary key,
	name varchar,
	cost_in_credits bigint,
	crew bigint,
	passenger bigint,
	cargo_capacity bigint,
	length bigint,
	max_atmospheric_speed integer,
	consumables varchar,
	model_idx integer
		constraint models_fk
			references transport_models
);

alter table transports owner to postgres;

