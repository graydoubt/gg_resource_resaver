# Demo

Open the `demo/data_model/item_type.gd` resource class, remove (or comment out) the unused `stats` property, and save the file.

Notice that the resources in `demo/data/items/` still contain the `stats = {}` line.

Open the "Resource Resaver" addon by going to `Project`, `Tools`, `Re-save Resources...`, and press `Run`.
It will update all resources to be in sync with their respective class definitions.
