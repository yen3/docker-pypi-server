# Simple pypi server

## Init server

- Generate username/password `docker run --rm yen3/htpasswd -nb <username> <password>`

  ```sh
  docker run --rm yen3/htpasswd -nb admin admin >! htpasswd.txt
  ```

- Start server


  ```sh
  docker-compose up -d
  ```

  If some error happen, please check
  1. Username and password are correct.
  2. The owner of folder `./packages` is `9898:9898`

- Stop server


  ```sh
  docker-compose down
  ```

## Python package command memo

- Install package

  ```sh
  pip install --extra-index-url http://127.0.0.1:10080 <package>
  ```

- Upload package

  ```sh
  python setup.py sdist bdist_wheel upload -r sample
  ```

- `$HOME/.pypirc` setting

  ```
  [distutils]
  index-servers = sample

  [sample]
  repository: http://127.0.0.1:10080
  username: admin
  password: admin
  ```
