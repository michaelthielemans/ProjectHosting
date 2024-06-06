# Hubble

## componenten

### Hubble UI
Grafische weergave
![](https://github.com/michaelthielemans/ProjectHosting/blob/main/images/hubble-ui.png)

### Hubble cli
Met de hubble cli tool kan je realtime packetten observeren
```
hubble observe --last 6 --follow --namespace kube-system
```
Capture trafiek en output dit naar een json file om te kunnen analyseren.
- follow : het process blijft actief tot je het onderbreekt ctrl-c
```
hubble observe --output jsonpb --last 1000 --follow --namespace ns-management > ns-management-flows.json
```
### Hubble relay
collector van data komende van meerdere nodes.

### Online networkpolicy editor
Met de network policy editor kan je via een grafische interface netwerk policies genereren. deze kan je vervolgens downloaden.
[https://editor.networkpolicy.io](https://editor.networkpolicy.io/)
