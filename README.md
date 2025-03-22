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

   Most of the values can stay as they are but `ha.cloudflare.account` details must be provided!

5. ```bash
   make run
   ```

   Apply tags:
   ```bash
   make run -- --tags=vim
   ```

## Equipment

### 1-Wire Bus Master

- https://arduino.ua/prod4832-master-shini-1-wire-s-galvanicheskoi-razvyazkoi-sdelano-v-ykraine (http://honey.com.ua/master/)

### DS18B20

- 28.258045D4A16C - air
- 28.746E46D41D45 - mbp
- 28.6FF345D48465 - balcony
