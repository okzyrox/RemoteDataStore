# Remote Datastore  system

for self hosted datastores..

WIP

## NOTE!

this is software that is NOT designed for official use in my opinion, because of the jank ass code, and lack of validation for fields atm, but just to test that something like this works

## Installation guide for the blind

### Server

install the packages:
`python -m pip install -r requirements.txt`

run the server:
`flask run`

### Roblox

create the module script from `module/init.lua`, copy all of its contents into it. name it whatever u like

put another module script as a child of the first one, called `settings.lua`

now import and work

## How to use:

Create a datastore:
`yourserverip:port/datastore/<name>/all`
creates a new datastore for u

Get a specific key:
`yourserverip:port/datastore/<name>/get/<key>`

Set a key to a new value:
`yourserverip:port/datastore/<name>/set/<key>/<value>`


# Credit:

Creator: @okzyrox
If you use this library, I ask that you give me credit somewhere within your game. Can just be the name of this module or my name.
License: MIT