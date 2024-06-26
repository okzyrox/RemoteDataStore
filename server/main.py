# Receiver server

import flask
import json
import os

from server import datastore

app = flask.Flask(__name__)
manager = datastore.DatastoreManager(
    "TESTKEY"
)

@app.route("/hb", methods=["GET"])
def heartbeat():

    return json.dumps({"alive": True})

@app.route("/datastore/<ds_name>/all", methods=["GET"])
def get_all_datastore(ds_name):
    if not ds_name:
        return "Error: No datastore name provided", 400

    return manager.getDatastore(ds_name).all()

@app.route("/datastore/<ds_name>/get/<key>", methods=["GET"])
def get_datastore(ds_name, key):
    if not ds_name:
        return "Error: No datastore name provided", 400
    if not key:
        return "Error: No key provided", 400

    datastore =  manager.getDatastore(ds_name)
    return datastore.get(key)
@app.route("/datastore/<ds_name>/set/<key>/<value>", methods=["GET", "POST"])
def set_datastore(ds_name, key, value):
    if not ds_name:
        return "Error: No datastore name provided", 400
    if not key:
        return "Error: No key provided", 400
    if not value:
        return "Error: No value provided", 400
    
    datastore = manager.getDatastore(ds_name)
    datastore.set(key, value)

    return datastore.all()