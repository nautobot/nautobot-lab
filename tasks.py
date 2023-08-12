from invoke import task


@task
def docker_build(context, version: str = "latest"):
    command = f"docker build -t networktocode/nautobot-lab:{version} ."
    context.run(command)
