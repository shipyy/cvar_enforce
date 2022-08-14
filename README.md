# Cvar Enforce

Enforce Cvars on maps with hardcoded settings like `sv_masvelocity` or `sv_airaccelerate` and allow to set a specific value of `sv_maxvelocity` for individual maps.

# Install

Download `CvarEnforce-v*.*.*.zip` from the latest release and afterwards drag and drop the contents into your `addons/sourcemod` folder

# Example

```python
"maxvel_maps.txt" should look like this:

<mapname>:<maxvel>
surf_pox:3500
surf_corruption:1000
```
