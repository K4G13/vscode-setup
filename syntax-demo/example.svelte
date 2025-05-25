<script>
    import { onMount } from 'svelte';
    
    // Props
    export let name = 'World';
    export let count = 0;
    
    // Reactive declarations
    $: doubled = count * 2;
    $: if (count > 10) {
        console.log('Count is getting high!');
    }
    
    // Lifecycle
    onMount(() => {
        console.log('Component mounted');
        return () => console.log('Component destroyed');
    });
    
    // Methods
    function incrementCount() {
        count += 1;
    }
    
    let colors = ['red', 'green', 'blue'];
</script>

<style>
    .container {
        font-family: 'Arial', sans-serif;
        max-width: 800px;
        margin: 0 auto;
        padding: 2rem;
        color: #333;
    }
    
    h1 {
        color: #ff3e00;
        text-transform: uppercase;
        font-size: 2em;
        font-weight: 100;
    }
    
    button {
        background: #ff3e00;
        color: white;
        border: none;
        padding: 0.5em 1em;
        border-radius: 4px;
        cursor: pointer;
    }
    
    button:hover {
        background: #ff6340;
    }
    
    .highlight {
        color: #ff3e00;
        font-weight: bold;
    }
</style>

<div class="container">
    <h1>Hello {name}!</h1>
    
    <p>Current count: <span class="highlight">{count}</span></p>
    <p>Doubled: {doubled}</p>
    
    <button on:click={incrementCount}>
        Increment count
    </button>
    
    {#if count > 5}
        <p>Count is greater than 5!</p>
    {:else}
        <p>Count is 5 or less</p>
    {/if}
    
    <h2>Color List</h2>
    <ul>
        {#each colors as color, i}
            <li style="color: {color}">Color {i+1}: {color}</li>
        {/each}
    </ul>
    
    {#await Promise.resolve('Async data') then value}
        <p>Resolved: {value}</p>
    {/await}
</div>
