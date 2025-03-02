import asyncio
import prefect
from prefect import flow, task
from src.data.ingest_data import ingest_main
from src.models.train import train_main
from src.evaluation.evaluate_model import evaluate_main

@task
def ingest_data_task():
    ingest_main()

@task
def train_model_task():
    train_main()

@task
def evaluate_model_task():
    evaluate_main()

@flow(name="astronomy_ml_flow")
def main_flow():
    """
    Orchestrates the entire ML pipeline using Prefect.
    """
    ingest_data_task_result = ingest_data_task.submit()
    train_model_task_result = train_model_task.submit(wait_for=[ingest_data_task_result])
    evaluate_model_task_result = evaluate_model_task.submit(wait_for=[train_model_task_result])

if __name__ == "__main__":
    # Start Prefect flow
    main_flow()
