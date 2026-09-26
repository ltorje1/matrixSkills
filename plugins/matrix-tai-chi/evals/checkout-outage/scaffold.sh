#!/usr/bin/env bash
# Workspace: deploy log and error sample for a checkout outage that started right after a deploy.
cat > deploy_log.txt <<'LOG'
2026-09-24 13:40 deploy v2.3.0 by ci  status=ok
2026-09-24 14:02 deploy v2.3.1 by ci  status=ok  changes: new tax calculation for EU carts (flag: none)
LOG
cat > error_sample.log <<'LOG'
14:05:12 ERROR checkout POST /api/checkout 500 KeyError: 'vat_rate' in tax.py:88 compute_eu_tax
14:05:13 ERROR checkout POST /api/checkout 500 KeyError: 'vat_rate' in tax.py:88 compute_eu_tax
14:05:19 INFO  checkout POST /api/checkout 200
14:05:21 ERROR checkout POST /api/checkout 500 KeyError: 'vat_rate' in tax.py:88 compute_eu_tax
14:06:02 WARN  payments retry queue depth=1840
LOG
