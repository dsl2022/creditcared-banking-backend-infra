const { DynamoDBClient, GetShardIteratorCommand, GetRecordsCommand } = require("@aws-sdk/client-dynamodb");

exports.handler = async (event) => {
    const ddbClient = new DynamoDBClient({ region: "us-east-1" });

    try {
        // Loop through each message received from the SQS queue
        for (const message of event.Records) {
            const shardInfo = JSON.parse(message.body);

            // Get a shard iterator for the shard
            const getShardIteratorCommand = new GetShardIteratorCommand({
                StreamArn: shardInfo.streamArn,
                ShardId: shardInfo.shardId,
                ShardIteratorType: "TRIM_HORIZON", // Adjust as needed
            });
            const shardIteratorResponse = await ddbClient.send(getShardIteratorCommand);

            // Use the shard iterator to read stream records
            const getRecordsCommand = new GetRecordsCommand({
                ShardIterator: shardIteratorResponse.ShardIterator
            });
            const recordsResponse = await ddbClient.send(getRecordsCommand);

            // Process the records
            for (const record of recordsResponse.Records) {
                // Your processing logic here
                console.log("Record: ", record);
            }
        }
    } catch (error) {
        console.error("Error processing DynamoDB stream shards:", error);
        throw error;
    }

    return { message: "DynamoDB stream shard processing complete" };
};
