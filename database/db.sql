create table app_scan_laps
(
    id          int auto_increment
        primary key,
    car         varchar(1000) null,
    lap_time    int           null,
    location    varchar(1000) null,
    user        varchar(1000) null,
    create_time timestamp     null
);

create table app_scan_points
(
    id          int auto_increment
        primary key,
    car         varchar(1000) null,
    scantime    datetime      null,
    location    varchar(1000) null,
    user        varchar(1000) null,
    points      int           null,
    create_time timestamp     null
);

create procedure save_laps_scan(IN car_param varchar(1000), IN location_param varchar(1000),
                                IN user_param varchar(1000), IN lap_time_param int)
BEGIN
INSERT INTO `stofgevreet`.`app_scan_laps`
(`car`,
 `location`,
 `user`,
 `lap_time`,
 `create_time`)
values (car_param,
        location_param,
        user_param,
        lap_time_param,
        current_timestamp());

END;

create procedure save_points_scan(IN car_param varchar(1000), IN scantime_param varchar(1000), IN points_param int,
                                  IN user_param varchar(1000), IN location_param varchar(1000))
BEGIN
INSERT INTO `stofgevreet`.`app_scan_points`
(`car`,
 `scantime`,
 `points`,
 `user`,
 `location`,
 `create_time`)
values (car_param,
        scantime_param,
        points_param,
        user_param,
        location_param,
        current_timestamp());

END;

