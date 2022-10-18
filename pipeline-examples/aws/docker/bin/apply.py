#!/usr/bin/python3

from python_terraform import *
import os

AWS_DEFAULT_REGION = os.environ.get("AWS_DEFAULT_REGION")
BACKEND_BUCKET = os.environ.get("BACKEND_BUCKET")
BACKEND_DYNAMODB_TABLE = os.environ.get("BACKEND_DYNAMODB_TABLE")
KEY_NAME = os.environ.get("BACKEND_KEY")

def pre_plan():
    layers_dir = f"{os.getcwd()}/workspace/layers"

    workspace_dir = f"{os.getcwd()}/workspace"
    workspace = os.path.exists(workspace_dir)
    if not workspace:
        os.mkdir(workspace_dir)

    tf_layers = []
    for folder in os.listdir(layers_dir):
        folder_dir = f"{layers_dir}/{folder}"
        if os.path.isdir(folder_dir):
            tf_layers.append(folder)

    return tf_layers, layers_dir, workspace_dir


def apply():
    tf_layers, layers_dir, workspace_dir = pre_plan()
    backend_config = {
        "bucket": BACKEND_BUCKET,
        "key": KEY_NAME,
        "region": AWS_DEFAULT_REGION,
        "encrypt": "true",
        "dynamodb_table": BACKEND_DYNAMODB_TABLE
    }
    for layer in tf_layers:
        os.chdir(f"{layers_dir}/{layer}")
        print(f"Executing Terraform Apply for {layer}")
        tf = Terraform(working_dir=f"{layers_dir}/{layer}")
        tf.init(backend_config=backend_config)
        apply = tf.apply(f"{workspace_dir}/terraform.{layer}.plan", var=None,no_color=IsFlagged)
        print(apply)


apply()
