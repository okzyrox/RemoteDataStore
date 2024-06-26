# datastore classes

import json, os


class Datastore:
    def __init__(self, path):
        self.path = path


    def all(self):
        with open(self.path, "r") as file:
            return json.load(file)

    def set(self, key, value):
        data = ""
        with open(self.path, "r") as file:
            data = json.load(file)
            file.close()
        data[key] = value
        with open(self.path, "w") as file:
            json.dump(data, file, indent=4)

    def get(self, key):
        with open(self.path, "r") as file:
            data = json.load(file) 
            if data[key]:
                constructed = f"{{ \"value\": \"{data[key]}\" }}"
                print(constructed)
                return json.loads(constructed)                

class DatastoreManager:
    def __init__(self, apiKey):
        self.stores = {}
        self.apiKey = apiKey


    def hasValidKey(self, apiKey):
        return apiKey == self.apiKey
    
    def newDatastore(self, name):
        if not os.path.exists("storage/" + name + ".json"):
            with open("storage/" + name + ".json", "w") as file:
                json.dump({}, file)
        path = "storage/" + name + ".json"
        return Datastore(path)
    
    def getDatastore(self, name) -> Datastore:
        if name not in self.stores:
            self.stores[name] = self.newDatastore(name)
        return self.stores[name]
