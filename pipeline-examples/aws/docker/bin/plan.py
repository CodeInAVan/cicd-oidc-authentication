#!/usr/bin/python3

# from azure.identity import ClientSecretCredential
# from azure.keyvault.secrets import SecretClient
from python_terraform import *
import os
import shutil

AWS_DEFAULT_REGION = os.environ.get("AWS_DEFAULT_REGION")
BACKEND_BUCKET = os.environ.get("BACKEND_BUCKET")
BACKEND_DYNAMODB_TABLE = os.environ.get("BACKEND_DYNAMODB_TABLE")
KEY_NAME = os.environ.get("BACKEND_KEY")

def pre_plan():
    artifacts = os.path.exists("/tmp/artifacts")
    if not artifacts:
        os.mkdir("/tmp/artifacts")

    layers_dir = f"{os.getcwd()}/layers"

    workspace_dir = f"{os.getcwd()}/workspace"
    workspace = os.path.exists(workspace_dir)
    if not workspace:
        os.mkdir(workspace_dir)

    tf_layers = []
    for folder in os.listdir(layers_dir):
        folder_dir = f"{layers_dir}/{folder}"
        if os.path.isdir(folder_dir):
            tf_layers.append(folder)
            shutil.copytree(
                src=folder_dir, dst=f"{workspace_dir}/layers/{folder}", dirs_exist_ok=True)

    return tf_layers, layers_dir, workspace_dir


def plan():
    # tenant_id, client_id, secret = authenticate_spn()
    tf_layers, layers_dir, workspace_dir = pre_plan()
    backend_config = {
        "bucket": BACKEND_BUCKET,
        "key": KEY_NAME,
        "region": AWS_DEFAULT_REGION,
        "encrypt": "true",
        "dynamodb_table": BACKEND_DYNAMODB_TABLE
    }
    print(tf_layers, layers_dir, workspace_dir)
    for layer in tf_layers:
        os.chdir(f"{layers_dir}/{layer}")
        print(f"Executing Terraform Plan for {layer}")
        tf = Terraform(working_dir=f"{layers_dir}/{layer}")
        tf.init(backend_config=backend_config)
        plan = tf.plan(out=f"{workspace_dir}/terraform.{layer}.plan")

        print(plan)


plan()
