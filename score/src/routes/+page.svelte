<script lang="ts">
	import { invalidateAll } from "$app/navigation";
	import { onMount } from "svelte";
    import type { PageData } from "./$types";
    import "ress";
    export let data: PageData;
    
    onMount(() => {
    setInterval(() => {
        invalidateAll();
    }, 2);
    });
</script>
<div id="bg">
    <img id="il1" src="/illust1.png" alt="background">
    <img id="il2" src="/illust2.png" alt="background">
    <img id="il3" src="/illust3.png" alt="background">
    <img id="il4" src="/illust4.png" alt="background">
</div>
<main>
    <div id="contain">
        <img src="/illust5.png" alt="logo"/>
        <h1>本日のTOP5</h1>
        <div id="scores">
            <div id="score">
                <h2>スコア</h2>
                <h2>達成時間</h2>
            </div>
            {#each data.top as score}
            <div id="score">
                <h2>{Math.floor(score.score)}</h2>
                <p>{score.time?.toLocaleTimeString()}</p>
            </div>
            {/each}
        </div>
        <h1>最新スコア</h1>
        <div id="scores">
            <div id="score">
                <h2>スコア</h2>
                <h2>達成時間</h2>
            </div>
            {#each data.resent as score}
            <div id="score">
                <h2>{Math.floor(score.score)}</h2>
                <p>{score.time?.toLocaleTimeString()}</p>
            </div>
            {/each}
        </div>
    </div>
</main>
<style>
    #scores {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-wrap: wrap;
        margin-bottom: 3rem;
    }
    #score {
        width: 100%;
        display: grid;
        grid-template-columns: 1fr 1fr;
        justify-content: center;
        align-items: center;
        margin: .1rem;
        padding: 1rem;
        background: rgba(0, 0, 0, 0.5);
        border-radius: 1rem;

    }

    #bg {
        position: fixed;
        top: 0;
        left: 0;
        width: 100vw;
        height: 100vh;
        background: #111;
        z-index: -1;
    }
    main {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        z-index: 1;
        color: yellow;
    }

    img {
        width: 100%;
    }

    #contain {
        width: 80%;
        height: 80%;
    }

    #il1 {
        position: fixed;
        bottom: 0;
        left: 0;
        z-index: -2;
    }

    #il2 {
        position: fixed;
        bottom: 5%;
        right: 0;
        z-index: -2;
    }

    #il3 {
        position: fixed;
        top: 20%;
        left: 0%;
        z-index: -2;
    }

    #il4 {
        position: fixed;
        top: 30%;
        right: 50%;
        z-index: -2;
    }

</style>