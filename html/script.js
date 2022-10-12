const scriptName = "glow_crafting";
let currentRecipe = null;
let currentBlueprint = null;

$("#crafting-recipes").on("contextmenu", ".recipe", function(event) {
    event.preventDefault();
    
    if ($("#discard").is(":visible")) {
        $("#discard").hide(); 
        currentBlueprint = null;
    }

    $("#craft").show().css({top: event.pageY + 15, left: event.pageX + 10});

    currentRecipe = $(this).attr("data-item");
})


$("#blueprint-slots").on("contextmenu", ".blueprint", function(event) {
    event.preventDefault();

    if ($(this).children().length == 0) {
        return
    }

    if ($("#craft").is(":visible")) {
        $("#craft").hide();
        currentRecipe = null;
    }

    $("#discard").show().css({top: event.pageY + 15, left: event.pageX + 10});

    currentBlueprint = $(this).find(".blueprint-text").attr("data-blueprint");
})

$(document).click(function() {
    if ($("#craft").is(":visible")) {
        const onMenu = $("#craft").is(":hover");
        if (!onMenu) {
            $("#craft").hide(); 
            currentRecipe = null;
        }
    }
    if ($("#discard").is(":visible")) {
        const onMenu = $("#discard").is(":hover");
        if (!onMenu) {
            $("#discard").hide();
            currentBlueprint = null;
        }
    }
})

$("#discard .menu-button").click(function() {
    if (currentBlueprint) {
        $.post(`https://${scriptName}/discardBlueprint`, JSON.stringify({currentBlueprint}), function(success) {
            if (success) {
                removeBlueprint(currentBlueprint);
                removeRecipe(currentBlueprint);
                currentBlueprint = null;
            }
        });
    }
    $("#discard").hide();
})

$("#craft .menu-button").click(function() {
    if (currentRecipe) {
        const amt = $(this).attr("data-craftAmt");

        const isBlueprintRecipe = ($(`[data-item="${currentRecipe}"]`).hasClass("blueprint-recipe"));
        $.post(`https://${scriptName}/attemptCraft`, JSON.stringify({currentRecipe, amt, isBlueprintRecipe}));
    }
    $("#craft").hide();
})

function displayBlueprints(recipes) {
    recipes.forEach(item => {
        addBlueprint(item);
        displayRecipe(item, true);
    })
    $(".recipe").fadeIn();
}

function displayDefaultRecipes(recipes) {
    for (const recipe in recipes) {
        displayRecipe(recipes[recipe], false);
    }

    $(".recipe").fadeIn();
}

function displayRecipe(craftData, isBlueprint) {
    let componentEl = ""
    craftData.components.forEach(item => {
        componentEl += 
        `<div class="component">
            <img src="${item.image}" alt="">
            <div class="component-text">${item.label}: ${item.amount}</div>
        </div>`;
    });

    $("#crafting-recipes").append(`
        <div class="recipe ${isBlueprint ? "blueprint-recipe": ""}" data-item="${craftData.item}" style="display: none;">
            <div class="recipe-img">
                <div class="recipe-text">${craftData.label}</div>
                <div class="craft-img">
                    <img src="${craftData.image}">
                </div>
            </div>
            <div class="recipe-components">
                ${componentEl}
            </div>
        </div>`)
}

function generateBlueprintSlots() {
    let blueprintEl = "";
    for (let i = 0; i < 5; i++) {
        blueprintEl += `<div class="blueprint" data-slot="${i}"></div>`;
    }

    $("#blueprint-slots").append(blueprintEl);
}

function addBlueprint(blueprint) {
    if ($(".blueprint-text").length < 5) {
        const emptySlot = $(`[data-slot="${$(".blueprint-text").length}"]`);
        emptySlot.append(`
            <div class="blueprint-text" data-blueprint="${blueprint.item}">${blueprint.label} Blueprint</div>
            <div class="craft-img">
                <img src="${blueprint.blueprintImage}">
            </div>`
        )
    }
}

function removeBlueprint(blueprintItem) {
    const blueprintEl = $(`[data-blueprint="${blueprintItem}"]`);
    blueprintEl.next().remove();
    blueprintEl.remove();
}

function removeRecipe(item) {
    $(`[data-item="${item}"]`).remove();
}

function clearUI() {
    currentRecipe = null;
    currentBlueprint = null;
    $("#search").val("");
    setTimeout(() => {
        $(".blueprint-text").remove();
        $(".blueprint .craft-img").remove();
        $(".recipe").remove();
    }, 500)
}

$("#search").on("keyup", function() {
    const searchTerm = $(this).val().toLowerCase();

    $(".recipe").each((index, item) => {
        if ($(item).find(".recipe-img .recipe-text").text().toLowerCase().indexOf(searchTerm) == -1) {
            $(item).hide();
        } else {
            $(item).show();
        }
    })
})

$(document).keyup(function(e){
    if (e.key == "Escape") {
        $.post(`https://${scriptName}/close`, JSON.stringify({}));
    }
})

window.addEventListener("message", function(event) {
    const item = event.data;

    switch(item.action) {
        case "show":
            $("#container").fadeIn();
            break;
        case "hide":
            $("#container").fadeOut();
            $(".contextMenu").fadeOut();
            clearUI();
            break;
        case "setupUI":
            generateBlueprintSlots();
            break;
        case "displayBlueprints":
            displayDefaultRecipes(item.default);
            displayBlueprints(item.blueprint);
            break;
        case "displayNewRecipes":
            displayDefaultRecipes(item.recipes)
            break;
    }
})
