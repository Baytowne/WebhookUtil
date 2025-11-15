# WebhookUtil

WebhookUtil is a lightweight Luau library designed for sending messages and rich embeds to Discord webhooks directly from Roblox using the HttpService. It supports multiple webhook URLs and provides a builder pattern for creating embeds.

## Installation


To use WebhookUtil in your Roblox project:

1. Copy the `WebhookUtil.luau` and `Embed.luau` files into your project's script directory.
2. Ensure the `Embed.luau` is a child of `WebhookUtil.lua` 
2. Require and use the module in your script:
   ```luau
   local WebhookUtil = require(path.to.WebhookUtil)
   local webhook = "https://discord.com/api/webhooks/..."

   local newWebhook = WebhookUtil.new(webhook)
   ```

## Usage

### Creating a WebhookUtil Instance

Initialize the utility with one or more Discord webhook URLs:

```luau
local webhook = WebhookUtil.new({
    "https://discord.com/api/webhooks/your-webhook-id/your-webhook-token"
})
```
> Be sure to replace discord.com with the proxy of your choice.,

### Sending a Simple Message

Send a plain text message:

```luau
webhook:Send("Hello, Discord!")
```

### Sending an Embed

Use the embed builder to create and send rich embeds:

```luau
local embed = webhook:CreateEmbed()
embed:SetTitle("My Embed Title")
embed:SetDescription("This is a description.")
embed:SetColor("FF0000")  -- Red
embed:AddField("Field Name", "Field Value", true)  -- args: fieldName, fieldValue, isInline
embed:SetTimestamp()
embed:SetThumbnail("https://example.com/image.png")
embed:SetFooter("Footer Text", "https://example.com/icon.png")

embed:Send()
```

### Advanced Sending

You can send custom data directly:

```luau
webhook:Send({ content = "Custom message" }, true)
```

## Notes

- Ensure that HttpService is enabled in your Roblox game settings.