# JG-AdvancedGarages (PAID)(QBCore)

## Overview

A fully featured, lightweight and easy to use multi-garage system for QBCore. Loosely based off the concept of qb-garages, I originally built this script for a roleplay server that I play on frequently, but it came out really nice I thought I should share it here. Here are some of the core features:

- 💎 Clean, intuitive and super easy to use Bootstrap-based interface
- 🚗 Configurable garage locations, with the ability to transfer and take out cars from any garage
- ✈️ Car, boat and air garage types
- 🚧 Vehicle impound with options such as self-retrieval, timer and reason
- 🧰 Proper job garages - job vehicles are owned vehicles and not just spawned in
- 💀 Gang garages - gangs can have owned vehicles which all gang members have access to
- 🏡 Private garages (for houses or other private properties)
- ✅ Spawn pileup protection
- 💻 Configurable admin commands for adding/removing job vehicles, changing vehicle plates and deleting vehicles from database
- ✨ Highly customisable config file and access to some callback functions to tailor the script for your servers needs
- ❤️ Responsive, one-to-one personal support available via Discord and updates to come!

The script is very well optimised, easy to configure and lightweight. It measures 0ms in background and just 0.04ms when active.

Dependencies:

- QBCore
- oxmysql
- LegacyFuel (configurable)

## Installation

- Move the resource inside of the `resources/[qb]` folder in your server
- Run the code inside run.sql in your MySQL database
- Configure the `config.lua` file as necessary for your needs!
- If you still have qb-garages or another garage script enabled, you should probably disable it so it doesn't conflict!

## Configuration

You can configure the script using `config.lua` for general personalisation for your server, and through `config-client.lua` to add custom code for certain script events such as when a vehicle is inserted into the garage. There are instructions throughout the comments in each file.

## Chat commands

- `/iv` - Impound vehicle (if in allowed jobs, default police only)
- `/createprivategarage` - Create a new private garage (if in allowed jobs, default realestate only)
- `/setjobvehicle [job_name]` - Move an owned vehicle to a job garage (admin only)
- `/removejobvehicle [new_player_owner_id]` - Put a job vehicle back into a player garage (admin only)
- `/setgangvehicle [gang_name]` - Move an owned vehicle to a gang garage (admin only)
- `/removegangvehicle [new_player_owner_id]` - Put a gang vehicle back into a player garage (admin only)
- `/vplate` - Change vehicle plate (admin only)
- `/dvdb` - Delete vehicle from database (admin only)

All commands are configurable in `config.lua`

## Garage Basics

- You can configure the prices of transfers to other garages, and returning of vehicles back to the garage if they are left out (or make them free)
- Vehicles of category `planes` or `helicopters` will show up in `air` garages, category `boats` will show up in `sea` garages and all other categories will show up in `car` garage types
- You can configure the distance at which the instruction overlays appear when you're near the garage

## Job Garages

- All vehicles in the job garage are owned - they need to be fueled, they can take damage and may need to be repaired :-)
- Once a vehicle has been purchased and is owned, admins can jump in the car and use `/setjobvehicle [job_name]` to move it to a job garage, where all players with that job will be able to access it
- Admins can use `/removejobvehicle [new_player_owner_id]` while in the car to give it back to a player and make it a personal vehicle again
- Note: the citizenid in the database stays as the original owner's ID - so an MDT database for example may show it's still owned by them. You can either adjust the code of that script, or potentially change the plate of the vehicle using `/vplate` to make it clear that it's a job owned vehicle

## Gang Garages

- Just like job garages, vehicles in the gang garage are owned by the gang, the garages are not just vehicle spawners
- Once a vehicle has been purchased and is owned, admins can jump in the car and use `/setgangvehicle [gang_name]` to move it to a gang garage, where all players in the gang can access it
- Admins can use `/removegangvehicle [new_player_owner_id]` while in the car to give it back to a player and make it a personal vehicle again
- Note: the citizenid in the database stays as the original owner's ID - so an MDT database for example may show it's still owned by them

## Impound

- Players with an enabled job (see `Config.ImpoundJobRestriction`) can use `/iv` when next to or inside a car to send it to the impound
- You can set a reason and whether the owner can retrieve it themselves. If this is set to false, only players with a whitelisted job can remove it from the impound for them
- If self-retrieval is enabled, you can set a time before they can take it out and a price they must pay (or 0)
- The owner of the vehicle can see in their garage that it has been impounded, the reason why and by who to avoid any confusion
- You can add one or more impound locations in `config.lua`. Vehicles that are impounded are available at every impound location.

## Private Garages

- Players with an enabled job (see `Config.PrivGarageCreateCommand`) can use `/createprivategarage` and a UI will appear guiding you through the process
- Only the player selected in the step above will be able to access the garage
- Deleting the garage has to be done through the datbase in the table `player_priv_garages`. Coming soon is a better way of handling this!

## Admin

- Use `/vplate` to set a new plate for the current vehicle
- Use `/dvdb` to delete the current vehicle from the database

