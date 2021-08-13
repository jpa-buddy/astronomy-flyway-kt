CREATE TABLE astronomical_body (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  mass DOUBLE PRECISION,
  atmosphere_id BIGINT,
  planet_id BIGINT,
  semi_major_axis DOUBLE PRECISION,
  orbital_period DOUBLE PRECISION,
  rotation_period DOUBLE PRECISION,
  rings BOOLEAN,
  CONSTRAINT pk_astronomical_body PRIMARY KEY (id)
);

CREATE TABLE atmosphere (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  description VARCHAR(255),
  pressure DOUBLE PRECISION,
  CONSTRAINT pk_atmosphere PRIMARY KEY (id)
);

CREATE TABLE atmospheric_gas (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  volume DOUBLE PRECISION,
  gas_id BIGINT,
  atmosphere_id BIGINT,
  CONSTRAINT pk_atmospheric_gas PRIMARY KEY (id)
);

CREATE TABLE carrier (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  CONSTRAINT pk_carrier PRIMARY KEY (id)
);

CREATE TABLE carrier_spaceport (
  carrier_id BIGINT NOT NULL,
  spaceport_id BIGINT NOT NULL,
  CONSTRAINT pk_carrier_spaceport PRIMARY KEY (carrier_id, spaceport_id)
);

CREATE TABLE company (
  id BIGINT NOT NULL,
  registration_id VARCHAR(255),
  company_type VARCHAR(255),
  CONSTRAINT pk_company PRIMARY KEY (id)
);

CREATE TABLE customer (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  email VARCHAR(255),
  grade VARCHAR(255),
  CONSTRAINT pk_customer PRIMARY KEY (id)
);

CREATE TABLE discounts (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  value DECIMAL(19, 2),
  grade VARCHAR(255),
  CONSTRAINT pk_discounts PRIMARY KEY (id)
);

CREATE TABLE gas (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  CONSTRAINT pk_gas PRIMARY KEY (id)
);

CREATE TABLE individual (
  id BIGINT NOT NULL,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  CONSTRAINT pk_individual PRIMARY KEY (id)
);

CREATE TABLE moon (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  mass DOUBLE PRECISION,
  atmosphere_id BIGINT,
  planet_id BIGINT,
  CONSTRAINT pk_moon PRIMARY KEY (id)
);

CREATE TABLE planet (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  mass DOUBLE PRECISION,
  semi_major_axis DOUBLE PRECISION,
  orbital_period DOUBLE PRECISION,
  rotation_period DOUBLE PRECISION,
  atmosphere_id BIGINT,
  rings BOOLEAN,
  CONSTRAINT pk_planet PRIMARY KEY (id)
);

CREATE TABLE spaceport (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  name VARCHAR(255),
  planet_id BIGINT,
  moon_id BIGINT,
  is_default BOOLEAN,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  CONSTRAINT pk_spaceport PRIMARY KEY (id)
);

CREATE TABLE waybill (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  reference VARCHAR(255),
  shipper_id BIGINT,
  consignee_id BIGINT,
  departure_port_id BIGINT,
  destination_port_id BIGINT,
  carrier_id BIGINT,
  total_weight DOUBLE PRECISION,
  total_charge DECIMAL(19, 2),
  CONSTRAINT pk_waybill PRIMARY KEY (id)
);

CREATE TABLE waybill_item (
  id BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
  number INTEGER,
  name VARCHAR(255),
  weight DOUBLE PRECISION,
  charge DECIMAL(19, 2),
  length DOUBLE PRECISION,
  width DOUBLE PRECISION,
  height DOUBLE PRECISION,
  waybill_id BIGINT,
  CONSTRAINT pk_waybill_item PRIMARY KEY (id)
);

ALTER TABLE astronomical_body ADD CONSTRAINT FK_ASTRONOMICAL_BODY_ON_ATMOSPHERE FOREIGN KEY (atmosphere_id) REFERENCES atmosphere (id);

ALTER TABLE astronomical_body ADD CONSTRAINT FK_ASTRONOMICAL_BODY_ON_PLANET FOREIGN KEY (planet_id) REFERENCES planet (id);

ALTER TABLE atmospheric_gas ADD CONSTRAINT FK_ATMOSPHERIC_GAS_ON_ATMOSPHERE FOREIGN KEY (atmosphere_id) REFERENCES atmosphere (id);

ALTER TABLE atmospheric_gas ADD CONSTRAINT FK_ATMOSPHERIC_GAS_ON_GAS FOREIGN KEY (gas_id) REFERENCES gas (id);

ALTER TABLE company ADD CONSTRAINT FK_COMPANY_ON_ID FOREIGN KEY (id) REFERENCES customer (id);

ALTER TABLE individual ADD CONSTRAINT FK_INDIVIDUAL_ON_ID FOREIGN KEY (id) REFERENCES customer (id);

ALTER TABLE moon ADD CONSTRAINT FK_MOON_ON_ATMOSPHERE FOREIGN KEY (atmosphere_id) REFERENCES atmosphere (id);

ALTER TABLE moon ADD CONSTRAINT FK_MOON_ON_PLANET FOREIGN KEY (planet_id) REFERENCES planet (id);

ALTER TABLE planet ADD CONSTRAINT FK_PLANET_ON_ATMOSPHERE FOREIGN KEY (atmosphere_id) REFERENCES atmosphere (id);

ALTER TABLE spaceport ADD CONSTRAINT FK_SPACEPORT_ON_MOON FOREIGN KEY (moon_id) REFERENCES moon (id);

ALTER TABLE spaceport ADD CONSTRAINT FK_SPACEPORT_ON_PLANET FOREIGN KEY (planet_id) REFERENCES planet (id);

ALTER TABLE waybill_item ADD CONSTRAINT FK_WAYBILL_ITEM_ON_WAYBILL FOREIGN KEY (waybill_id) REFERENCES waybill (id);

ALTER TABLE waybill ADD CONSTRAINT FK_WAYBILL_ON_CARRIER FOREIGN KEY (carrier_id) REFERENCES carrier (id);

ALTER TABLE waybill ADD CONSTRAINT FK_WAYBILL_ON_CONSIGNEE FOREIGN KEY (consignee_id) REFERENCES customer (id);

ALTER TABLE waybill ADD CONSTRAINT FK_WAYBILL_ON_DEPARTURE_PORT FOREIGN KEY (departure_port_id) REFERENCES spaceport (id);

ALTER TABLE waybill ADD CONSTRAINT FK_WAYBILL_ON_DESTINATION_PORT FOREIGN KEY (destination_port_id) REFERENCES spaceport (id);

ALTER TABLE waybill ADD CONSTRAINT FK_WAYBILL_ON_SHIPPER FOREIGN KEY (shipper_id) REFERENCES customer (id);

ALTER TABLE carrier_spaceport ADD CONSTRAINT fk_carspa_on_carrier FOREIGN KEY (carrier_id) REFERENCES carrier (id);

ALTER TABLE carrier_spaceport ADD CONSTRAINT fk_carspa_on_spaceport FOREIGN KEY (spaceport_id) REFERENCES spaceport (id);