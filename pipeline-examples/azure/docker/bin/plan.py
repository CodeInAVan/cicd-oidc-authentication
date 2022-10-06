#!/usr/bin/python3

# from azure.identity import ClientSecretCredential
# from azure.keyvault.secrets import SecretClient
from python_terraform import *
import os
import shutil

ARM_CLIENT_ID = os.environ.get("AZURE_CLIENT_ID")
ARM_OIDC_TOKEN= os.environ.get("CIRCLE_OIDC_TOKEN")
ARM_TENANT_ID = os.environ.get("AZURE_TENANT_ID")
ARM_SUBSCRIPTION_ID = os.environ.get("AZURE_SUBSCRIPTION_ID")
ARM_BACKEND_ACCESS_KEY = os.environ.get("BACKEND_ACCESS_KEY")
RESOURCE_GROUP_NAME = os.environ.get("BACKEND_RG")
STORAGE_ACCOUNT_NAME = os.environ.get("BACKEND_SG")
CONTAINER_NAME = os.environ.get("BACKEND_CONTAINER")
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
        "access_key": ARM_BACKEND_ACCESS_KEY,
        "resource_group_name": RESOURCE_GROUP_NAME,
        "storage_account_name": STORAGE_ACCOUNT_NAME,
        "container_name": CONTAINER_NAME,
        "key": KEY_NAME
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
