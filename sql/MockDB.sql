create table if not exists Foods (
    foodID numeric(6, 0) not null,
    foodName varchar(30) not null,
    foodType varchar(30),
    primary key (foodID)
);

create table if not exists Sodas (
	sodaID numeric(6, 0) not null,
    sodaName varchar(30) not null,
    sodaType varchar(30),
    primary key (sodaID)
);

create table if not exists SpecificPairings (
	foodID numeric(6, 0) not null, 
    sodaID numeric(6, 0) not null,
    primary key (foodID, sodaID), 
    foreign key (foodID) references Foods(foodID),
    foreign key (sodaID) references Sodas(sodaID)
);

create table if not exists Restaurants (
	restaurantID numeric(6, 0) not null,
    restaurantName varchar(30) not null,
    restaurantaddr varchar(30) not null,
    primary key (restaurantID)
);

create table if not exists FoodMenuEntry (
	restaurantID numeric(6, 0) not null,
    foodID numeric(6, 0) not null,
    primary key (restaurantID, foodID),
    foreign key (restaurantID) references Restaurants(restaurantID),
    foreign key (foodID) references Foods(foodID)
);

create table if not exists SodaMenuEntry (
	restaurantID numeric(6, 0) not null,
    sodaID numeric(6, 0) not null,
    primary key (restaurantID, sodaID),
    foreign key (restaurantID) references Restaurants(restaurantID),
    foreign key (sodaID) references Sodas(sodaID)
);

create table if not exists Users (
	userID numeric(6, 0) not null,
    username varchar(30) not null,
	PW varchar(30) not null,
    primary key (userID)
);

insert into Foods values (123456, 'steak', 'meaty');
insert into Foods values (789123, 'potatoes', 'starchy');
insert into Foods values (456789, 'stuffing', 'bready');
insert into Foods values (147258, 'gravy', 'savory');
insert into Foods values (258369, 'turkey', 'meaty');

insert into Sodas values (123456, 'pepsi', 'kick');
insert into Sodas values (789123, 'coke', 'kick');
insert into Sodas values (456789, 'fanta', 'fruity');
insert into Sodas values (147258, 'sprite', 'lime');
insert into Sodas values (258369, 'barqs', 'classic');

insert into SpecificPairings values (123456, 456789);
insert into SpecificPairings values (456789, 789123);
insert into SpecificPairings values (789123, 123456);
insert into SpecificPairings values (123456, 789123);
insert into SpecificPairings values (456789, 123456);

insert into Restaurants values (123456, 'tonys', '1234 Road');
insert into Restaurants values (789123, 'harry buffalo', '4567 Drive');
insert into Restaurants values (456789, 'chipotle', '7891 Lane');
insert into Restaurants values (147258, 'melt', '2345 Avenue');
insert into Restaurants values (258369, 'mcdonalds', '4568 Parkway');

insert into FoodMenuEntry values (123456, 456789);
insert into FoodMenuEntry values (456789, 789123);
insert into FoodMenuEntry values (789123, 123456);
insert into FoodMenuEntry values (123456, 789123);
insert into FoodMenuEntry values (456789, 123456);

insert into SodaMenuEntry values (123456, 456789);
insert into SodaMenuEntry values (456789, 789123);
insert into SodaMenuEntry values (789123, 123456);
insert into SodaMenuEntry values (123456, 789123);
insert into SodaMenuEntry values (456789, 123456);

insert into Users values (123456, 'emf65', 'sodarox');
insert into Users values (456789, 'damien', 'cats101');
insert into Users values (789123, 'sarah', 'database');