# MuseScore MacOS QuickLook & Thumbnail Provider

To check if the plugin is loaded by macOS, run

```bash
pluginkit -m -v -i com.musescore.MuseScoreQLPreviewProvider
```

To view the logs for the plugin, run

```bash
log stream --predicate 'process == "MuseScoreQLPreviewProvider"'
```