# Home Assistant Nest

## Requirements

- A Debian device with an SSH access (e.g. a Raspberry Pi).
- A domain name that uses Cloudflare for DNS.
- Python 3.13+, i.e. https://www.python.org/downloads/release/python-3132/

## Install

1. ```bash
   make venv
   . venv/bin/activate
   ```

2. ```bash
   make i
   ```

   If fails, do `pip install --upgrade pip` and repeat.

3. Edit servers inside the [inventory.yml](inventory.yml).

4. ```bash
   cp env.yml.example env.yml
   ```

   - Most of the values can stay as they are but `ha.cloudflare.*` details must be provided!
   - There is only `CNAME` tunnel support (subdomain).

5. ```bash
   make run
   ```

   Apply tags:
   ```bash
   make run -- --tags=vim
   ```

## Shortcuts

### Reinstall and reconfigure the Cloudflare tunnel

```bash
make run -- --tags=cf
```
