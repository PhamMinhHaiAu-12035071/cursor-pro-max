Organize the work in phases and make more todos so we can hand off the phased work to different engineers/agents in chunks that can either be done sequentially and/or parallelized. Be sure the todos have a [Phase X] in their content.

- [Phase 1] Map current system (repos, services, data flows)
- [Phase 1] List all user-facing flows we must keep working
- [Phase 2] Set up unified repo + CI/CD
- [Phase 2] Port core logic from App A into the unified repo
- [Phase 2] Port core logic from App B into the unified repo
- [Phase 3] Wire end-to-end flow A → B in staging
- [Phase 3] Add monitoring, logging, and basic alerts
- [Phase 4] Run canary release and compare outputs vs old apps
- [Phase 4] Turn off old apps after stable period