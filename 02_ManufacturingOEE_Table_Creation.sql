USE ManufacturingOEE;


-- Creation of OEE_Data table
CREATE TABLE OEE_Data (
    `date`           varchar(20)  NULL,
    machine_id          varchar(20)  NULL,
    shift               varchar(20)  NULL,
    planned_hours       decimal(10,2) NULL,
    actual_hours        decimal(10,2) NULL,
    availability_pct    decimal(8,5) NULL,
    performance_pct     decimal(8,5) NULL,
    quality_pct         decimal(8,5) NULL,
    oee_pct             decimal(8,5) NULL,
    units_produced      int NULL,
    defects             int NULL
);


