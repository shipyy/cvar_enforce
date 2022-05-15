# ez_config
Enforce Cvars on maps with hardcoded settings (i.e. "sv_maxvelocity") and allow to set a specific value of `sv_maxvelocity` for each map.

The whitelist containing the maxvel maps must be in `/csgo/addons/sourcemod/configs/surftimer/maxvel_maps.txt`

`maxvel_maps.txt` should look like this:
```python
<mapname>:<maxvel>
surf_pox:3500
surf_mesa:3500
surf_beginner:1000
surf_runewords:2000
surf_zen2:6666
surf_corruption:4567
```
