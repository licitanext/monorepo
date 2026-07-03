# skills/

Agent Skills específicos de LicitaNext, siguiendo el patrón del boilerplate
`lapc506/flutter-agentic-boilerplate`: cada skill es una carpeta con un
`SKILL.md` que aporta instrucciones y contexto especializado, con carga
progresiva.

```
skills/
├── flutter/    # Skills de la app móvil (features, UI atómica, theming)
├── backend/    # Skills de hunter-core (ingesta SICOP, match UNSPSC, alertas)
└── cicd/       # Skills de infra/despliegue (Minikube, KNative, OVH)
```

Los skills **genéricos** (los ~54 del boilerplate: Riverpod, Clean
Architecture, GitHub Actions, Terraform, etc.) no se duplican aquí; se
referencian desde el boilerplate. En este directorio solo van los skills con
conocimiento propio de LicitaNext (p. ej. el formato de datos abiertos SICOP o
el diccionario de sinónimos UNSPSC).

La taxonomía de labels de Linear vive en [`../AGENTS.md`](../AGENTS.md).
