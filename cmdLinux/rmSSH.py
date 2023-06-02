import argparse
import paramiko

# Valores predeterminados
DEFAULT_IP = "10.0.10.1"
DEFAULT_USERNAME = "rmonla"
DEFAULT_PASSWORD = "default_password"

def execute_remote_command(ip, username, password, command):
    ssh_client = paramiko.SSHClient()
    ssh_client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    ssh_client.connect(ip, username=username, password=password)

    stdin, stdout, stderr = ssh_client.exec_command(command)
    output = stdout.read().decode().strip()
    error = stderr.read().decode().strip()

    if output:
        print(f"Output:\n{output}")

    if error:
        print(f"Error:\n{error}")

    ssh_client.close()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Ejecución de comando remoto")
    parser.add_argument("-comm", help="Comando a ejecutar en el equipo remoto")
    parser.add_argument("-ip", default=DEFAULT_IP, help="Dirección IP del equipo remoto")
    parser.add_argument("-usr", default=DEFAULT_USERNAME, help="Nombre de usuario para la conexión SSH")
    parser.add_argument("-psw", default=DEFAULT_PASSWORD, help="Contraseña para la conexión SSH")
    args = parser.parse_args()

    ip = args.ip
    username = args.usr
    password = args.psw
    command = args.comm

    if command is None:
        parser.print_usage()
    else:
        execute_remote_command(ip, username, password, command)
