import mlflow
import mlflow.tensorflow
from mlflow.tracking import MlflowClient

def setup_mlflow(
    experiment_name: str = "astronomy_experiment",
    tracking_uri: str = "http://localhost:5000",
    registry_uri: str = None
):
    """
    Configure MLflow for logging metrics and artifacts.
    """
    mlflow.set_tracking_uri(tracking_uri)
    if registry_uri:
        mlflow.set_registry_uri(registry_uri)

    # Create or get the experiment
    client = MlflowClient()
    try:
        experiment_id = client.create_experiment(experiment_name)
    except Exception:
        experiment = client.get_experiment_by_name(experiment_name)
        experiment_id = experiment.experiment_id

    mlflow.set_experiment(experiment_name)
    mlflow.tensorflow.autolog()
    return experiment_id

def log_metrics(metrics_dict: dict):
    for k, v in metrics_dict.items():
        mlflow.log_metric(k, v)

def log_params(params_dict: dict):
    for k, v in params_dict.items():
        mlflow.log_param(k, v)
