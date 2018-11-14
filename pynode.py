#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os
import json
import web3
import sys
from web3 import Web3

# from web3.contract import ConciseContract

from threading import Thread
import time
import asyncio


ipcProvider1 = "/home/pi/privateChain/miner1_1/geth.ipc"
ipcProvider2 = "/home/pi/privateChain/miner2_1/geth.ipc"
ipcProvider3 = "/home/pi/privateChain/miner3_1/geth.ipc"
ipcProvider4 = "/home/nvidia/opt/privateChain/miner4_1/geth.ipc"


def deployContract(contract_interface, web3_instance):

    # Instantiate and deploy contract
    Greeter = web3_instance.eth.contract(abi=contract_interface['abi'], bytecode=contract_interface['bin'])

    # Submit the transaction that deploys the contract
    tx_hash = Greeter.constructor().transact()

    # Wait for the transaction to be mined, and get the transaction receipt
    tx_receipt = web3_instance.eth.waitForTransactionReceipt(tx_hash)

    return tx_receipt


async def handle_event_publisher_initialize(myWeb3, myContract, poll_interval):

    event_filter = myContract.events.Message.createFilter(fromBlock="latest")
    while True:
        for event in event_filter.get_new_entries():
            handle_event_publisher(myWeb3, myContract, event)
        await asyncio.sleep(poll_interval)

def handle_event_publisher(myWeb3, myContract, event):

    if str(event["args"]["topic"]) == "complete":
        print(time.asctime(),": Account ",myWeb3.eth.defaultAccount," received a new message (complete)");
        print("time: ",str(event["args"]["_time"]),"  Topic: ",str(event["args"]["topic"]));
        print("Final accepted models: \n" , str(event["args"]["hash"]));
    else:
        print(time.asctime(),": bypass unrelated message")
    # and whatever

async def handle_event_contributor1_initialize(myWeb3, myContract, poll_interval):

    event_filter = myContract.events.Message.createFilter(fromBlock="latest")
    while True:
        for event in event_filter.get_new_entries():
            handle_event_contributor1(myWeb3, myContract, event)
        await asyncio.sleep(poll_interval)

def handle_event_contributor1(myWeb3, myContract, event):

    if str(event["args"]["topic"]) == "train":
        print(time.asctime(),": Account ",myWeb3.eth.defaultAccount," received a new message (train)");
        print("time: ",str(event["args"]["_time"]),"  Topic: ",str(event["args"]["topic"]));

        print(time.asctime(),": start training")
        sys.path.insert(0, "/home/pi/IPFS_TEST/Computing_contributor1/")
        from con1_m import con1
        result = con1(float(event["args"]["hash"]))
        print(time.asctime(),": complete training")

        print(time.asctime(),": Publishing training result: ",result[0])
        tx_hash = myContract.functions.sendMessage(myWeb3.eth.defaultAccount, 'verify', ",".join(str(i) for i in result)).transact()
        # Wait for transaction to be mined...
        tx_receipt = myWeb3.eth.waitForTransactionReceipt(tx_hash)
        print(time.asctime(),": Successfully post training result.")


    else:
        print(time.asctime(),": bypass unrelated message")
    # and whatever

async def handle_event_contributor2_initialize(myWeb3, myContract, poll_interval):

    event_filter = myContract.events.Message.createFilter(fromBlock="latest")
    while True:
        for event in event_filter.get_new_entries():
            handle_event_contributor2(myWeb3, myContract, event)
        await asyncio.sleep(poll_interval)

def handle_event_contributor2(myWeb3, myContract, event):

    if str(event["args"]["topic"]) == "train":
        print(time.asctime(),": Account ",myWeb3.eth.defaultAccount," received a new message (train)");
        print("time: ",str(event["args"]["_time"]),"  Topic: ",str(event["args"]["topic"]));

        print(time.asctime(),": start training")
        sys.path.insert(0, "/home/pi/IPFS_TEST/Computing_contributor2/")
        from con2_m import con2
        result = con2(float(event["args"]["hash"]))
        print(time.asctime(),": complete training")

        print(time.asctime(),": Publishing training result: ",result[0])
        tx_hash = myContract.functions.sendMessage(myWeb3.eth.defaultAccount, 'verify', ",".join(str(i) for i in result)).transact()
        # Wait for transaction to be mined...
        tx_receipt = myWeb3.eth.waitForTransactionReceipt(tx_hash)
        print(time.asctime(),": Successfully post training result.")

    else:
        print(time.asctime(),": bypass unrelated message")
    # and whatever

async def handle_event_verifier_initialize(myWeb3, myContract, poll_interval):

    event_filter = myContract.events.Message.createFilter(fromBlock="latest")
    models_holder = set()
    while True:
        for event in event_filter.get_new_entries():
            models_holder = handle_event_verifier(myWeb3, myContract, event, models_holder)
        await asyncio.sleep(poll_interval)

def handle_event_verifier(myWeb3, myContract, event, models_holder):

    if str(event["args"]["topic"]) == "verify":
        if tuple(event["args"]["hash"].split(",")) not in models_holder:
            models_holder.add(tuple(event["args"]["hash"].split(",")))
            print(time.asctime(),": Account ",myWeb3.eth.defaultAccount," received a new message(verify)");
            print("time: ",str(event["args"]["_time"]),"  Model: ",str(event["args"]["hash"]));

            if len(models_holder) == 2:
                print(time.asctime(),": start verification")
                sys.path.insert(0, "/home/nvidia/opt/IPFS_TEST/Verification_contributor/")
                from verifier_m import verifier
                os.chdir("/home/nvidia/opt/IPFS_TEST/Verification_contributor/")
                result = verifier(list(models_holder))
                print(time.asctime(),": complete verification")
                models_holder = set()

                print(time.asctime(),": Publishing verification result: ",result)
                tx_hash = myContract.functions.sendMessage(myWeb3.eth.defaultAccount, 'complete', ",".join(str(i) for i in result)).transact()
                # Wait for transaction to be mined...
                tx_receipt = myWeb3.eth.waitForTransactionReceipt(tx_hash)
                print(time.asctime(),": Successfully post verification result.")

                return models_holder
            else:
                return models_holder
        else:
            print(time.asctime(),": received duplicated message")
            return models_holder
    else:
        print(time.asctime(),": bypass unrelated message")
        return models_holder
    # and whatever

def create_event_publisher_initialize(myWeb3, myContract, poll_interval):

    # while True:

    create_event_publisher(myWeb3, myContract)
        # await asyncio.sleep(poll_interval)

def create_event_publisher(myWeb3, myContract):

    print(time.asctime(),": Publishing training task")
    tx_hash = myContract.functions.sendMessage(myWeb3.eth.defaultAccount, 'train', "0.901").transact()
    # Wait for transaction to be mined...
    tx_receipt = myWeb3.eth.waitForTransactionReceipt(tx_hash)
    print(time.asctime(),": Successfully post training task")

def main(argv):

    ipcProvider = ipcProvider1
    if len(argv) == 1:
        print("Plase indicate the role of current ETH client")
        print("\te.g.: $./pynode.py p/c1/c2/v/d")
        print("\t\tp - publisher")
        print("\t\tc1 - trainer 1")
        print("\t\tc2 - trainer 2")
        print("\t\tv - verifier")
        print("\t\td - deploy contract")
        return
    elif argv[1] == "p":
        ipcProvider = ipcProvider1

    elif argv[1] == "c1":
        ipcProvider = ipcProvider2

    elif argv[1] == "c2":
        ipcProvider = ipcProvider3

    elif argv[1] == "v":
        ipcProvider = ipcProvider4

    elif argv[1] == "d":
        ipcProvider = ipcProvider1

    print("connecting IPC Provider")


    # web3.py instance
    web3_instance = Web3(Web3.IPCProvider(ipcProvider))

    from web3.middleware import geth_poa_middleware
    web3_instance.middleware_stack.inject(geth_poa_middleware, layer=0)

    print("Connected to IPC provider of " , web3_instance.version.node)

    # set pre-funded account as sender
    web3_instance.eth.defaultAccount = web3_instance.eth.accounts[0]

    # compiled_sol = compile_source(contract_source_code) # Compiled source code
    # contract_interface = compiled_sol['<stdin>:MetaCoin']

    with open('contracts.json', 'r') as abi_definition:
          contracts_abi = json.load(abi_definition)

    if argv[1] == "d":

        print("deploying contract")
        contractInstance = web3_instance.eth.contract(abi=contracts_abi["contracts"]["MetaCoin.sol:MetaCoin"]["abi"],\
                                                        bytecode=contracts_abi["contracts"]["MetaCoin.sol:MetaCoin"]['bin'])

        # Submit the transaction that deploys the contract
        tx_hash = contractInstance.constructor().transact()

        # Wait for the transaction to be mined, and get the transaction receipt
        tx_receipt = web3_instance.eth.waitForTransactionReceipt(tx_hash)
        print("deployed contract")

        with open("contractKey.txt", 'w') as f:
            f.write(str(tx_receipt.contractAddress))

        print("saved contract address")

        return

    with open("contractKey.txt", 'r') as f:
        contractAddress = f.read()

    # Create the contract instance with the newly-deployed address
    contractInstance = web3_instance.eth.contract(
        # address=tx_receipt.contractAddress,
        address=Web3.toChecksumAddress(contractAddress),
        abi=contracts_abi["contracts"]["MetaCoin.sol:MetaCoin"]["abi"],
    )

    loop = asyncio.get_event_loop()

    if argv[1] == "p":
        print("Publisher is online")
        create_event_publisher_initialize(web3_instance, contractInstance, 1)
        try:
            loop.run_until_complete(
                asyncio.gather(
                    handle_event_publisher_initialize(web3_instance, contractInstance, 1)
                ))
        finally:
            loop.close()

    elif argv[1] == "c1":
        print("Trainer 1 is online")
        try:
            loop.run_until_complete(
                asyncio.gather(
                    handle_event_contributor1_initialize(web3_instance, contractInstance, 1)
                ))
        finally:
            loop.close()

    elif argv[1] == "c2":
        print("Trainer 2 is online")
        try:
            loop.run_until_complete(
                asyncio.gather(
                    handle_event_contributor2_initialize(web3_instance, contractInstance, 1)
                ))
        finally:
            loop.close()

    elif argv[1] == "v":
        print("Verifier is online")
        try:
            loop.run_until_complete(
                asyncio.gather(
                    handle_event_verifier_initialize(web3_instance, contractInstance, 1)
                ))
        finally:
            loop.close()
    else:
        print("Plase indicate the role of current ETH client")

        # .. do some other stuff

if __name__ == '__main__':
    main(sys.argv)
