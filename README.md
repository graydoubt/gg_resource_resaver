# Resource Resaver Tool

This "Resource Resaver" tool is a small addon that automates re-saving all `.tres` files in your project.
This is useful if you've modified a resource class definition (`.gd` file) and need to update all corresponding `.tres` files.


## Why do I need this?

This tool is intended to ensure all resources are in sync and to prevent noisy diffs with regards to version control.
This is especially helpful in team environments when merging feature branches.


### The Problem

Resources consist of two parts:
The resource class definition, which is the `.gd` script that `extends Resource`, and any resources created from it, which are the `.tres` files that essentially represent serialized objects written to disk.

After modifying a resource class definition, Godot does not automatically change all affected resources in your project.
It updates only resources that are explicitly edited/saved in the inspector.

Especially in larger, heavily data-driven projects, this means the `.tres` resources on disk become outdated.
They still function as intended at runtime, so there is no logical issue here.
It merely means that, if the resource is saved again, it will result in a change in the on-disk representation.

This becomes problematic in a team environment if one developer modifies a resource class definition, by adding or removing a property, but without updating all of the affected resources.

If another developer temporarily edits the resource missing the change, or modifies a scene that includes an in-line resource missing the change, the pull request from developer B will potentially include changes to seemingly unrelated resource files, which may show up as a merge conflict.

This scenario can be avoided if the developer modifying the resource class definition uses this "Resource Resaver" addon to ensure that all affected resources are up-to-date.
It eliminates the need to manually open and save each resource to force the update.


## Installation

1. Add the `gg_resource_resaver` addon into your `addons/` directory.
2. Enable the plugin from `Project`, `Project Settings`, `Plugins`.


## Usage

Navigate to `Project`, `Tools`, `Re-save Resources...` to open the tool and press the `Run` button.


## Acknowledgements

This tool was developed in response to [this Reddit post](https://www.reddit.com/r/godot/comments/1j98gje/is_there_any_way_to_update_all_resources_of_a/),
which also details the problem scenario.
