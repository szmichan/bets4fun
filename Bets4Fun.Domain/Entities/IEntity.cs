namespace Bets4Fun.Domain.Entities
{
    public interface IEntity<T>
    {
        T Id { get; }
    }
}
